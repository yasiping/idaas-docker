#!/bin/bash

set +e
set -o noglob

bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

red=$(tput setaf 1)
green=$(tput setaf 76)
white=$(tput setaf 7)
tan=$(tput setaf 202)
blue=$(tput setaf 25)

underline() { printf "${underline}${bold}%s${reset}\n" "$@"
}
h1() { printf "\n${underline}${bold}${blue}%s${reset}\n" "$@"
}
h2() { printf "\n${underline}${bold}${white}%s${reset}\n" "$@"
}
debug() { printf "${white}%s${reset}\n" "$@"
}
info() { printf "${white}➜ %s${reset}\n" "$@"
}
success() { printf "${green}✔ %s${reset}\n" "$@"
}
error() { printf "${red}✖ %s${reset}\n" "$@"
}
warn() { printf "${tan}➜ %s${reset}\n" "$@"
}
bold() { printf "${bold}%s${reset}\n" "$@"
}
note() { printf "\n${underline}${bold}${blue}Note:${reset} ${blue}%s${reset}\n" "$@"
}

set -e
set +o noglob

version=$1
deploy_mode=$2

readonly ARGS="$@"
readonly ARGN="$#"
usage() {
cat << EOF

    usage:
    ftp_upload.sh version deploy_mode

    example:
    ftp_upload.sh 1.0.0 REGISTRY
    ftp_upload.sh develop REGISTRY_TO_ZIP

EOF
}

process() {
if [ $deploy_mode = "REGISTRY" ];then
  mv idaas-docker-solo-$version.tar.gz idaas-docker-solo-$version-registry.tar.gz
  dstfile=idaas-docker-solo-$version-registry.tar.gz
else
  dstfile=idaas-docker-solo-$version.tar.gz
fi
dstmd5file=$dstfile.md5

md5sum $dstfile >$dstmd5file

ftp -n -i 192.168.238.112 <<EOF

user ywkf ywkf

binary

cd /ftp/mc-idaas/idaas-release

lcd ${PWD}

put $dstmd5file
put $dstfile

bye

EOF

echo "Upload to FTP successfully."

}

parse() {
    if [ 2 -ne $ARGN ]; then
        usage
        exit
    fi

    while getopts ":h" opt; do
        case "$opt" in
        "h")
            usage
            exit
        ;;

        *)
            echo "Invalid option: -$OPTARG"
            usage
            exit
        ;;
        esac
    done
}

check_args() {
    #if [[ ! $version =~ ^[0-9]*\.[0-9]*\.[0-9]*$ ]] && [ "$version" != "develop" ]; then
    if [ 0 == 1 ]; then
        error "Incorrect syntax of the version"
        exit 1
    else
        #if [ "$version" != "develop" ]; then
        #    version='v'$version
        #fi
        note "upload version: $version"
    fi
}


main() {
    parse $ARGS
    check_args
    process
}

main
