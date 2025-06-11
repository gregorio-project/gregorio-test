eval $gregorio -F bad test.gabc
[[ $? == "1" ]] || exit 1
