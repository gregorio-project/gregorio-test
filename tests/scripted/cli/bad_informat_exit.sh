eval $gregorio -f bad test.gabc
[[ $? == "1" ]] || exit 1
