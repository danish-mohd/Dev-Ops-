#!/bin/bash

# some examples
# ./hashPassword.sh --text hello --length 20 --algo md5
# ./hashPassword.sh  hello --length 20 --algo md5
# ./hashPassword.sh --t hello -l 20 -al md5


# initiaze the parameter with their default values
plainText=""
algo=(sha1 sha256 sha512 md5 sm3)
length=15

if [[ $# -eq "0" ]]
    then
        # assign some random text to plain text.
        plainText=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w15 | head -n 1)
    else

        # if there are odd number of params then first arg would be the plain text
        if [[ $(($# % 2)) -eq "1" ]]
            then
                plainText=$1
                shift
        fi
        
        while [ $# -gt 0 ]; do
            echo first arg is $1
            case "$1" in
                --text|-t )
                    plainText=$2
                    ;;

                --algo|-a )
                    algo=($2)
                    ;;

                --length|-l )
                    length=$2
                    ;;

                *)
                    echo "Invalid parameter: $1. "
                    exit 1
            esac
            shift
            shift
        done
fi

for algo in ${algo[@]}
do
    password=$(echo -n $plainText | openssl dgst -$algo | sed 's/^.*= //')
    echo Alogorithm : $algo
    echo Password   : ${password::$length}
    echo ""
done