#!/bin/sh

# count the no of times each word appear in a given file.
output=output.txt
filename=$1

if [ $# -ne 1 ]
    then
    echo "Please pass the valid file name in script argument"
    exit 2
fi

if [ ! -f $filename ]
    then
        echo "Invalid input filename"
        exit 1
fi

if [ ! -f $output ]
    then    
        touch $output
        chmod a+w $output
fi


echo '' > $output
tr -s '[:blank:]|,|.' '[\n*]' < $filename |
sort -u -f |
while IFS= read -r word
do
  count=$(grep -io $word $filename | wc -l)
  echo $word $count >> $output
done 

sort -r -k 2,2 -k 1,1 $output
rm $output
