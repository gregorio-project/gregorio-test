EXPECTED="warning: several error files declared, out1.log taken"

OUTCOME=$("$gregorio_path" -l out1.log -l out2.log test.gabc 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
