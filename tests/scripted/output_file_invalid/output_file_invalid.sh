mkdir test.dump
EXPECTED="error: can't write to file test.dump"

OUTCOME=$(eval $gregorio -F dump test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
