eval $gregorio -F gabc -F dump -F gtex test.gabc
[[ $? == "1" ]] || exit 1
