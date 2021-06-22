#!/bin/sh
JDK_NAME=openjdk8
export CAPAA_HOME=/capaa
PROJECT_HOME=/capaa/mc-center
DATA_HOME=/data/mc-center
JAVA_HOME=$JAVA_HOME/bin/java
_RUNJAVA=$DATA_HOME/java/jdk1.8.0_201/bin/java

option=$1
DefaultOption=""

if [ ! -x $_RUNJAVA ]; then
  _RUNJAVA=java
fi

if [ "$option" = "" ]; then
  option=start
  DefaultOption="start"
fi

AppFileName="mc-center.jar"
BASE_PATH=$(cd -P $(dirname $0)/..;pwd)
AppFile=$BASE_PATH/jar/${AppFileName}
AppCfgFile=/data/mc-center/conf/application.yml
startupma=${AppFileName}
ProName=${0}
ProName=$(echo $ProName | awk -F"/" '{print $NF}')
ProcName=mc_center

export LIB_PATH=$DATA_HOME/lib

FilePid=/run/capaa/${ProcName}.pid
SLCKFILE=/run/capaa/${ProcName}.start.lck
DLCKFILE=/run/capaa/${ProcName}.stop.lck
LCKFILE=/run/capaa/${ProcName}.$1.lck

XMS="512m"
XMX="1024m"
JVM_MEM="-server -Xms$XMS -Xmx$XMX"
JVM_OPTS=" -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:ParallelGCThreads=5 -XX:SurvivorRatio=2"
JAVA_LIB_PATH=" -Djava.library.path=${LIB_PATH}"

updateConfigFile() {
  #echo "uc-center.accessPath=${1}" > "/data/mc-center/conf/mc_center_access_path.conf"
  echo "请手动修改项目访问路径"
}

operation() {
  case "$option" in
  start)
    start
    ;;
  stop)
    stopp
    ;;
  restart)
    restart
    ;;
  status)
    status
    rt=$?
    UnLockProcessFile $LCKFILE
    exit $rt
    ;;
  version)
    version
    ;;
  -j)
    ;;
  -o)
    ;;
  -a)
    ;;
  *)
    #echo "Usage: $ProName {start|stop|restart|status}"
    help
    ;;
  esac
}

start() {
  export LD_LIBRARY_PATH=$DATA_HOME/lib

  startopt=1
  pid=$(ps -ef | grep -w "${startupma}" | grep -v "grep" | awk '{print $2}')
  #pid=`getcpid "${startupma}"`
  if [ "$pid" = "" ]; then
    startopt=0
  else
    pnum=$(echo $pid | wc -w)
    if [ $pnum = 1 ]; then
      CheckProcessStata $pid >/dev/null
      if [ $? = 0 ]; then
        echo && echo "Hint: Process '${ProcName}':[$pid] is already running!" && echo
        startopt=1
      else
        startopt=0
      fi
    else
      echo "Warning:More Then One Process Running,it's will restart $ProcName"
      ps -ef | grep -w "${startupma}" | grep -v "grep" | awk '{print $2}' | xargs kill -9 >/dev/null
      if [ $? = 0 ]; then
        startopt=0
      else
        echo "Error:failed to stop all $ProcName process"
        startopt=1
      fi
    fi
  fi

  if [ $startopt = 0 ]; then
    if [ -x $_RUNJAVA ]; then
      nohup $_RUNJAVA $JVM_MEM $JVM_OPTS $JAVA_LIB_PATH -jar ${AppFile} --spring.config.additional-location=${AppCfgFile} >/dev/null 2>&1 &
      #echo $! > "$FilePid"
    else
      #echo "file "$_RUNJAVA" does not exist."
      if [ -x $JAVA_HOME ]; then
#        nohup $JAVA_HOME $JVM_MEM $JVM_OPTS $JAVA_LIB_PATH -jar ${AppFile} --spring.config.additional-location=${AppCfgFile} >/dev/null 2>&1 &
         /usr/bin/supervisord -c /etc/supervisord.conf -n
      else
        echo "Warning:JAVA_HOME for system not found."
      fi
    fi

    med_SN_1=10
    while [ $med_SN_1 -gt 0 ]; do
      med_SN_1=$(expr $med_SN_1 - 1)
      pid=$(ps -ef | grep -w "${startupma}" | grep -v "grep" | awk '{print $2}')
      if [ "$pid" != "" ]; then
        break
      fi
      sleep 1
    done
    if [ "$pid" = "" ]; then
      echo && echo "Error:Start Process '${ProcName}' fail." && echo
      pid=a123838
    else
      echo && echo "Hint:Start Process '${ProcName}':[$pid] successful." && echo
    fi
  fi

  if [ -f $FilePid ]; then
    fpid=$(cat $FilePid)
    if [ "$fpid" != "$pid" ]; then
      echo "$pid" >"$FilePid"
    fi
  else
    echo "$pid" >"$FilePid"
  fi
}

status() {
  #0 normal runing          Rpid=Fpid
  #1 normal stop            Rpid=Fpid=null
  #2 Exception stop         Rpid=null Fpid<>null
  #3 More Then one running  Rpid Proc >2
  #4 Exception running      Rpid<>null Fpid=null
  #5 Runing ErorrFilePid    Rpid<>Fpid
  #pid=`ps -ef|grep -w "${startupma}"|grep -v "grep" | awk '{print $2}'`
  pid=$(getcpid "${startupma}")
  if [ -f $FilePid ]; then
    fpid=$(cat $FilePid)
    if [ "$fpid" != "" ]; then
      if [ "$pid" = "" ]; then
        echo && echo "Error:Process '${ProcName}':[$fpid] Exception Stopped!" && echo
        return 2
      else
        pnum=$(echo $pid | wc -w)
        if [ $pnum = 1 ]; then
          if [ $fpid = $pid ]; then
            ThreadNum=$(pstree -p $pid | wc -l)
            if [ $ThreadNum -lt 3000 ]; then
              echo && echo "Hint:Process '${ProcName}':[$pid] is running." && echo
              return 0
            else
              echo && echo "Hint:Process '${ProcName}':[$pid] Thread More Than [$ThreadNum] ." && echo
              return 6
            fi
          else
            echo && echo "Warning:Process '${ProcName}' RunPid:[$pid] <> FilePid:[$fpid]." && echo
            return 5
          fi
        else
          echo "Warning:More Then one Process '${ProcName}'  Running."
          return 3
        fi
      fi
    else
      #fpid=null
      if [ "$pid" = "" ]; then
        echo && echo "Hint:Process '${ProcName}' ShutDown Normal." && echo
        return 1
      else
        LockProcessFile $SLCKFILE >/dev/null
        if [ $? != 0 ]; then
          echo "Warning: ${ProcName} starting"
        else
          LockProcessFile $DLCKFILE >/dev/null
          if [ $? != 0 ]; then
            echo "Warning: ${ProcName} stoping"
          else
            echo && echo "Hint:Process '${ProcName}' Exception Running." && echo
            return 4
          fi
        fi
      fi
    fi
  else
    if [ "$pid" = "" ]; then
      echo && echo "Hint:Process '${ProcName}' ShutDown Normal." && echo
      return 1
    else
      LockProcessFile $SLCKFILE >/dev/null
      if [ $? != 0 ]; then
        echo "Warning: ${ProcName} starting"
      else
        LockProcessFile $DLCKFILE >/dev/null
        if [ $? != 0 ]; then
          echo "Warning: ${ProcName} stoping"
        else
          echo && echo "Hint:Process '${ProcName}' Exception Running." && echo
          return 4
        fi
      fi
    fi
  fi
}

stopp() {
  #0 normal runing          Rpid=Fpid
  #1 normal stop            Rpid=Fpid=null
  #2 Exception stop         Rpid=null Fpid<>null
  #3 More Then one running  Rpid Proc >2
  #4 Exception running      Rpid<>null Fpid=null
  #5 Runing ErorrFilePid    Rpid<>Fpid
  if [ -f $FilePid ]; then
    fpid=$(cat $FilePid)
  fi
  >$FilePid
  pid=$(ps -ef | grep -w "${startupma}" | grep -v "grep" | awk '{print $2}')
  #pid=`getcpid "${startupma}"`
  if [ "$pid" = "" ]; then
    echo && echo "Hint:Process ${ProcName} is Not Active!" && echo
  else
    ps -ef | grep -w "${startupma}" | grep -v "grep" | awk '{print $2}' | xargs kill -9 >/dev/null 2>&1
    if [ $? = 0 ]; then
      echo && echo "Hint:Stop ${ProcName}:[$pid] succeed." && echo
    else
      echo && echo "Error:Stop ${ProcName}:[$pid] fail." && echo
      echo "$pid" >$FilePid
    fi
  fi
}

restart() {
  stopp
  start
}

version() {
  if [ ! -d /data/mc-center ]; then
    echo "Not exist version File:'$BASE_PATH/version'"
  fi
  cat $BASE_PATH/version | while read line
  do
      echo $line
  done
}

getcpid ()
{
 CPNAME=$1
 if [ "$CPNAME" != "" ];then
     ps -ef|grep -w "$CPNAME"|grep -v grep |while read line
     do
       iCPPID=`echo $line|awk '{print $2}'`
       iROOTID=`echo $line|awk '{print $3}'`
#       iCPNAME=`echo $line|awk '{print $8}'`
       if [ "$iROOTID" = "1" ];then
            echo $iCPPID
       fi
     done
   else
     return 1
 fi
}

CheckProcessStata()
{
    CPS_PID=$1
    CPS_PNAME=$2
    if [ "$CPS_PID" != "" ] ;then
        CPS_PIDLIST=`ps -ef|grep $CPS_PID|grep -v grep|awk -F" " '{print $2}'`
    else
        CPS_PIDLIST=`ps -ef|grep "$CPS_PNAME"|grep -v grep|awk -F" " '{print $2}'`
    fi

    for CPS_i in `echo $CPS_PIDLIST`
    do
        if [ "$CPS_PID" = "" ] ;then
            CPS_i1="$CPS_PID"
        else
            CPS_i1="$CPS_i"
        fi

        if [ "$CPS_i1" = "$CPS_PID" ] ;then
            #kill -s 0 $CPS_i
            kill -0 $CPS_i > /dev/null 2>&1
            if [ $? != 0 ] ;then
                echo "[`date`] MC-10500: Process $i have Dead"
                kill -9 $CPS_i > /dev/null 2>&1
                return 1
            else
                #echo "[`date`] MC-10501: Process is alive"
                return 0
            fi
        fi
    done
    echo "[`date`] MC-10502: Process $CPS_i is not exists"
    return 1
}

LockProcessFile(){
  LPF_FILE=$1
  LPFDIR=`dirname ${LPF_FILE}`
  if [ ! -d $LPFDIR ];then
     echo "mkdir $LPFDIR"
      mkdir -p $LPFDIR
  fi
  LPF_MMDD=`date +%Y%m%d%H%M%S`
  ln -s ${LPF_FILE}:${LPF_MMDD}:$$ $LPF_FILE.lck >/dev/null 2>&1
  if [ $? != 0 ] ;then
    #ls -l $LPF_FILE.lck
    LPF_PID=`ls -l $LPF_FILE.lck|awk -F"->" '{print $2}'|awk -F":" '{print $3}'`
    if [ "$LPF_PID" = "" ] ;then
      rm -f $LPF_FILE.lck
      ln -s ${LPF_FILE}:${LPF_MMDD}:$$ $LPF_FILE.lck >/dev/null 2>&1
    else
      #echo "CheckProcessStata $LPF_PID"
      CheckProcessStata $LPF_PID
      if [ $? != 0 ] ;then
        rm -f $LPF_FILE.lck
        ln -s ${LPF_FILE}:${LPF_MMDD}:$$ $LPF_FILE.lck >/dev/null 2>&1
      else
        return 1
      fi
    fi
  fi
}

UnLockProcessFile(){
  UPF_FILE=$1
  if [ -L $UPF_FILE.lck ] ;then
    rm -f $UPF_FILE.lck
  fi
}

help() {
  echo "-j ：Specify the Java run path, such as '-j /capaa/jdk/openjdk/bin/java'"
  echo "-o : Specify the operation, such as '-o {start|stop|restart|status|version}'"
  echo "-a : Modify the access address of the mc-center project, such as '-a https://192.168.60.1:8020'"
  echo "If you want to get more help information, please go to http://wiki.mchz.com.cn/pages/viewpage.action?pageId=26352447"
}

LockProcessFile $LCKFILE >/dev/null
if [ $? != 0 ]; then
  echo "Warning: startup-${ProcName}.sh.$1 is alive and pls waiting for"
  exit 1
fi

while getopts 'j:o:a:' OPT; do
  case $OPT in
  #指定JDK
  j)
    _RUNJAVA="$OPTARG"
    ;;
  #指定操作
  o)
    option="$OPTARG"
    operation
    ;;
  #修改配置文件
  a)
    updateConfigFile $OPTARG
    ;;
  *)
    help
    break
    ;;
  esac
done

if [ "$DefaultOption" != "" ]; then
    operation
fi

processLog() {
  USER=`id |cut -d"(" -f2 | cut -d ")" -f1`
  echo "[`date '+%Y-%m-%d %H:%M:%S'`] ${USER} : $option" >> /data/mc-center/log/process.log
}
processLog

UnLockProcessFile $LCKFILE

