mkdir test.dump
eval $gregorio -F dump test.gabc
[[ $? == "1" ]] || exit 1
