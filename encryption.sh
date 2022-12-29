#!/bin/bash


input_text=""   # input text that needed to encrypt/decrypt
encryption_password='hOq96xEXfVTpU3ecZdeqZ8Fdvx6g5e'
iteration=10
encryption_algorithm=("aes-128-cbc" "aes-128-ecb" "aes-256-cbc" "aes-256-ecb" "des" "des-cbc")
isDecrypt=""

echo $@

if [[ $# -eq "0" ]]
    then
        input_text=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w15 | head -n 1)
    else    
        input_text=$1
fi

if [[ $(echo $@ | grep -e "-d" ) -eq "1" ]]
    then
        isDecrypt="-d"
        echo decrypting $input_text
    else
        echo encripting $input_text
fi

for algo in ${encryption_algorithm[@]}
do
    res=$(echo $input_text | openssl $algo -a -salt $isDecrypt -k $encryption_password -iter $iteration)
    echo Password $res
    echo Alogorithm $algo
    echo ""
done