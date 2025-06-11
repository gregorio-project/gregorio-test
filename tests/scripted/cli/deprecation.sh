source test-gtex.rc

OUTCOME=$(eval $gregorio -D -S test.gabc)

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
