source test-gtex.rc

OUTCOME=$(cat test.gabc | eval $gregorio -s -s)

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
