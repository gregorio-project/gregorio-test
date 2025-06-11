eval $gregorio -l out1.log -l out2.log test.gabc
[[ $? == "0" ]] || exit 1
