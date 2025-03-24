EXPECTED="Gregorio [0-9]\.[0-9]\.[0-9](-[a-zA-Z0-9.-]{1,}-[0-9a-f]{8}-[0-9]{1,})?( \(kpathsea version [0-9]\.[0-9]\.[0-9]\))?\.
Copyright \(C\) 2006-202[0-9] Gregorio Project authors \(see CONTRIBUTORS\.md\)
License GPLv3\+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl\.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law\."

OUTCOME=$(eval $gregorio -V)

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
