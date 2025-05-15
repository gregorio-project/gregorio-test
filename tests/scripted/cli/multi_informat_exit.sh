eval $gregorio -f gabc -f gabc test.gabc
[[ $? == "0" ]] || exit 1
