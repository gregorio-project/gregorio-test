eval $gregorio -d -S bad.gabc
[[ $? == "1" ]] || exit 1
