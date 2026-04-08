source test-gtex.rc
echo "$EXPECTED"

echo ==========
OUTCOME=$(cat test.gabc | "$gregorio_path" -s -s | tr -d '\r')
echo ==========
echo "$OUTCOME"

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
