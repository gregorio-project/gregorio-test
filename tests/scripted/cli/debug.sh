source test-gtex.rc

OUTCOME=$(eval $gregorio -d -S test.gabc | tr -d '\r')

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
