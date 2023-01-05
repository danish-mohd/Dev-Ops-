#!/bin/bash


input_text=""   # input text that needed to encrypt/decrypt
encryption_password='hOq96xEXfVTpU3ecZdeqZ8Fdvx6g5e'    # password to encrypt the plain text
iteration=10    # iteration count
encryption_algorithm=("aes-128-cbc" "aes-128-ecb" "aes-256-cbc" "aes-256-ecb") # list of algorithms
isDecrypt=""

echo $@

if [[ $# -eq "0" ]]
    then
        input_text=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w15 | head -n 1)
    else    
        input_text=$1
        shift

        while [ $# -gt 0 ]; do
            echo first arg is $1
            case "$1" in
                --algo|-a )
                    encryption_algorithm=($2)
                    echo encryption_algorithm is $encryption_password[@]
                    ;;

                --itr|-i )
                    iteration=$2
                    echo iteration is $iteration
                    ;;

                --epass|-p )
                    encryption_password=$2
                    echo encryption_password is $encryption_password
                    ;;

                --decrypt|-d )
                    isDecrypt="-d"
                    echo isDecrypt is $isDecrypt
                    ;;

                *)
                    echo "Invalid parameter: " $1
                    exit 1
            esac
            shift
            shift
        done
fi

for algo in ${encryption_algorithm[@]}
do
    res=$(echo $input_text | openssl $algo -a -salt $isDecrypt -k $encryption_password -iter $iteration)
    echo Password $res
    echo Alogorithm $algo
    echo ""
done