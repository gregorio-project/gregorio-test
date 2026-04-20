source test-gtex.rc
echo "$EXPECTED"

echo ==========
OUTCOME=$("$gregorio_path" -d -S test.gabc | tr -d '\r')
echo ==========
echo "$OUTCOME"

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
