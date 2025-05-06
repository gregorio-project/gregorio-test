source test-gtex.rc

OUTCOME=$(eval $gregorio -S -o out.out test.gabc)

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
