source test-gtex.rc

OUTCOME=$(cat test.gabc | eval $gregorio -s -s | tr -d '\r')

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
