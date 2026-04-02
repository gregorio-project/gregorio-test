source test-gtex.rc

OUTCOME=$(eval $gregorio -D -S test.gabc | tr -d '\r')

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
