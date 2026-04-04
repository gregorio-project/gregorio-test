source test-gtex.rc

OUTCOME=$("$gregorio_path" -D -S test.gabc | tr -d '\r')

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
