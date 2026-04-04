source test-gtex.rc

OUTCOME=$("$gregorio_path" -S -o out.out test.gabc | tr -d '\r')

[[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
