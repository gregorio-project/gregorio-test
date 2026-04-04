source test-gtex.rc

OUTCOME=$(cat test.gabc | "$gregorio_path" -s -p | tr -d '\r')

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
