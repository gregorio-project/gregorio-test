source test-gtex.rc

OUTCOME=$(eval $gregorio -S -o out.out test.gabc | tr -d '\r')

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
