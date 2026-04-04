source test-gtex.rc

OUTCOME=$("$gregorio_path" -S -S test.gabc | tr -d '\r')

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
