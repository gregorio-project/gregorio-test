source test-gtex.rc
echo $EXPECTED

OUTCOME=$(eval $gregorio -d -S test.gabc)
echo
echo $OUTCOME

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
