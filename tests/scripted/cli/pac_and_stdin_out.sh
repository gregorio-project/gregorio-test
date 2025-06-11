source test-gtex.rc

OUTCOME=$(cat test.gabc | eval $gregorio -s -p)

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
