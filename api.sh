#!/bin/bash

if [[ $# -eq 0 ]]
then
    echo "Please enter the search term"
    exit 1
fi

searchTerm=$1 
searchProperty="Link"
header='[ "API", "Category", "Link" ], ["----", "--------", "-----"]'
fields="[ .API, .Category, .Link]"
filter=$( echo "select(.$searchProperty|test(\".*$searchTerm.*\"; \"i\"))")
query=$( echo "$header, (.entries[] | $filter | $fields )| @csv")
url="https://api.publicapis.org/entries"

curl $url |         # fetch data from api
jq -r "$query" |    # query the json result and returns the csv date
tr -d '^"\|"$' |    # trim the comma
column -t -s "," | # transform to table view
head -n 21      # returns only top 20 rows (2 lines are headers).