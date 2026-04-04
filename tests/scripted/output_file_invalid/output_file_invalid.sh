mkdir test.dump
EXPECTED="error: can't write to file test.dump"

OUTCOME=$("$gregorio_path" -F dump test.gabc 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
