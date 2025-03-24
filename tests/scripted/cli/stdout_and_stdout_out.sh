source test-gtex.rc

OUTCOME=$(eval $gregorio -S -S test.gabc)

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
