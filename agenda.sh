awk 'BEGIN { 
    print "Today|Tomorrow" 
    OFS="|"
}{
    nextLine=""
    blank=""

    nextLine
    if ($1 ~ "Today" ) {
        if(getline nextLine > 0) {
            print nextLine, blank
        }
    }
    else if ($1 ~ "Tomorrow" ) {
        if(getline nextLine > 0) {
            print blank, nextLine
        }
    }

}' agenda.txt | column -t -s "|"