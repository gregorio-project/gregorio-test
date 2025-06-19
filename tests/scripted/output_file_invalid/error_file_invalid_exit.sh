mkdir test.log
eval $gregorio -l test.log test.gabc
[[ $? == "1" ]] || exit 1
