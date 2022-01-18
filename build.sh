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

readonly ARGS="$@"
readonly ARGN="$#"
version=$1
gitauth=$2

deploy_mode=$3
registry_server="192.168.239.29:5000"
FTP_HOST=192.168.238.112

parse() {
    if [ 3 -ne $ARGN ]; then
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

usage() {
cat << EOF

    usage:
    build.sh version gitauth

    example:
    build.sh 1.0.0 johnsmith:123456
    build.sh develop johnsmith:123456

EOF
}

check_args() {
    note "building version: $version"

    if [[ ! $gitauth =~ ^.+:.+$ ]]; then
        error "Incorrect syntax of the git auth"
        exit 1
    fi
}

prepare() {
    sed -i 's/IDAAS_VERSION=.*$/IDAAS_VERSION='$version'/g' .env
#    sed -i 's/"version":.*/"version": "'$version'",/g' ENV/omp.config.json
    image_names=$(cat docker-compose.yaml | grep "^[[:space:]]*image:" | grep -v "filebeat:" | grep -v "kibana:" | sed -e "s/\s*image:\s*//g" | sed -e "s/:.*//g")
    images=''
    for image_name in $image_names; do
        images=${images}' '${image_name}:${version}
    done

#    if [ $version == 'develop' ]; then
#      mv docker-compose.yaml docker-compose.yaml.bk
#      mv docker-compose-develop.yaml docker-compose.yaml
#    fi
    sed -i 's/${IDAAS_VERSION}/'$version'/g' docker-compose.yaml
}

build_images() {

#    docker build --build-arg VERSION=$version --build-arg GITAUTH=$gitauth -t idaas-base:${version} ./APP/idaas-base
    
    build_ok=1
    for i in 1 2 3 4 5; do
        build_ok=0
        docker-compose build --force-rm --build-arg VERSION=$version \
                                        --build-arg GITAUTH=$gitauth \
                                        --parallel || build_ok=1

        if [ $build_ok -eq 0 ]; then
            success "$app build complete"
            break;
        else
            warn "$i error occur, retry in 30 seconds"
            sleep 30
        fi
    done

    
    if [ $build_ok -ne 0 ];then
        exit 1
    fi
}

pack_images() {
    
    images=${images}
    if [ $deploy_mode = "REGISTRY_TO_ZIP" ];then

        info "pull images begin"
            for image in $images
            do
                info "pulling $registry_server/$image"
                docker pull $registry_server/$image
            done
        success "pull images complete"

        info "download & unzip package begin"
        wget -q ftp://ywkf:ywkf@$FTP_HOST/mc-idaas/idaas-release/idaas-docker-solo-$version-registry.tar.gz
        tar -zxf idaas-docker-solo-$version-registry.tar.gz
        success "download & unzip complete"

        info "save images begin"
            for image in $images
            do
                docker tag $registry_server/$image $image
            done

            echo "images:$images"
            docker save -o ./idaas-docker/images/osc-idaas.tar $images

        success "save images complete"

        info "zip begin"
        tar -czvf idaas-docker-solo-$version.tar.gz idaas-docker
        success "zip complete"

        return 0
    fi
    rm -rf ./idaas-docker
    mkdir -p ./idaas-docker
    mkdir -p ./idaas-docker/images
#    mkdir -p ./idaas-docker/idaas_env/etc/
    mkdir -p ./idaas-docker/idaas_env/var/lib/mysql
    mkdir -p ./idaas-docker/idaas_env/etc/mysql
    mkdir -p ./idaas-docker/idaas_env/data/mc-center/conf

#    mv  mc-center  ./idaas-docker/idaas_env/

    if [ $version == 'develop' ]; then
      mkdir -p ./idaas-docker/log/idaas
    fi

    if [ ! -n "$deploy_mode" ] || [ $deploy_mode = "ZIP" ];then
        info "save images begin"
        echo "images:$images"
        docker save -o ./idaas-docker/images/osc-idaas.tar $images
        success "save images complete"
    elif [ $deploy_mode = "REGISTRY" ];then
        info "push images begin"
        for image in $images
        do
            echo "$image => $registry_server/$image"
            docker tag $image $registry_server/$image
            docker push $registry_server/$image
        done
        success "push images complete"
    fi
    cp docker-compose.yaml ./idaas-docker/docker-compose.yaml
    cp ENV/*.cnf ./idaas-docker/idaas_env/etc/mysql/
    cp ENV/db_init.sql ./idaas-docker/idaas_env/
    cp ENV/appIndexUrlOrder.txt ./idaas-docker/idaas_env/data/mc-center/conf/
    cp -r ENV/docker-entrypoint-initdb.d ./idaas-docker/idaas_env/
    cp .env ./idaas-docker/
    sed -i '/build:/d' ./idaas-docker/docker-compose.yaml
#    cp ./ENV/my.cnf ./idaas-docker/idaas_env/etc/my.cnf
    cp -r ./deploy ./idaas-docker

    info "pack begin"
    tar -czvf idaas-docker-solo-$version.tar.gz idaas-docker
    success "pack complete"
    rm -rf ./idaas-docker
}

main() {
    parse $ARGS
    check_args
    prepare
    if [ $deploy_mode != "REGISTRY_TO_ZIP" ];then
        build_images
    fi
    pack_images
}

main
