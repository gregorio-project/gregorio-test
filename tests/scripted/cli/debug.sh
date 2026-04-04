source test-gtex.rc

OUTCOME=$("$gregorio_path" -d -S test.gabc | tr -d '\r')

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
