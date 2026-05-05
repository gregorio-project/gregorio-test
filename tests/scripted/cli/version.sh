EXPECTED="Gregorio [0-9]\.[0-9]\.[0-9](-(beta|rc)[0-9]{1,})?(-[a-zA-Z0-9./_-]{1,}-[0-9a-f]{8}-[0-9]{1,})?( \(kpathsea version [0-9]\.[0-9]\.[0-9]\))?\.
Copyright \(C\) 2006-202[0-9] Gregorio Project authors \(see CONTRIBUTORS\.md\)
License GPLv3\+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl\.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law\."
echo "$EXPECTED"

echo ==========
OUTCOME=$("$gregorio_path" -V | tr -d '\r')
echo ==========
echo "$OUTCOME"

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
