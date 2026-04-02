source test-gtex.rc

OUTCOME=$(eval $gregorio -S -S test.gabc | tr -d '\r')

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
