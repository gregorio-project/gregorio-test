mkdir test.log
EXPECTED="error: can't open file test.log for writing"

OUTCOME=$(eval $gregorio -l test.log test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
