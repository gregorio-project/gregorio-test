EXPECTED="warning: several error files declared, out1.log taken"

OUTCOME=$(eval $gregorio -l out1.log -l out2.log test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
