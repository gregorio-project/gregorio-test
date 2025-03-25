source test-gtex.rc

OUTCOME=$(eval $gregorio -d -S test.gabc)

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
