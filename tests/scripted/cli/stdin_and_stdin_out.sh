source test-gtex.rc
echo $EXPECTED

OUTCOME=$(cat test.gabc | eval $gregorio -s -s)
echo
echo $OUTCOME

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
