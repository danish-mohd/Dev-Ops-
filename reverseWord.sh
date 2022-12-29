#!/bin/bash
# Following script will print the give line in reverse order

line=$@
result=()

if [[ $# -lt 1 ]]
    then
        echo Please pass atleast one argument
        exit 2
fi
index=0

for word in $line
do
    rword=$(echo $word | rev)
    result+=($rword)
done

echo Reverse value is \"${result[@]}\"