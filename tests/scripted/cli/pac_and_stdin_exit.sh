cat test.gabc | eval $gregorio -s -p
[[ $? == "0" ]] || exit 1
