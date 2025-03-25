cat test.gabc | eval $gregorio -s -s
[[ $? == "0" ]] || exit 1
