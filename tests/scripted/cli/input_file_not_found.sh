EXPECTED="error: can't open file notfound.gabc for reading"

OUTCOME=$("$gregorio_path" notfound.gabc 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
