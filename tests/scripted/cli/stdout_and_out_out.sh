source test-gtex.rc
echo $EXPECTED

OUTCOME=$(eval $gregorio -S -o out.out test.gabc)
echo
echo $OUTCOME

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
