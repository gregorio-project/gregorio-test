EXPECTED="error: can't open file notfound.gabc for reading"

OUTCOME=$(eval $gregorio notfound.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
