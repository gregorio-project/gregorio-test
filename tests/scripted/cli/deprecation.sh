source test-gtex.rc
echo $EXPECTED

OUTCOME=$(eval $gregorio -D -S test.gabc)
echo
echo $OUTCOME

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
