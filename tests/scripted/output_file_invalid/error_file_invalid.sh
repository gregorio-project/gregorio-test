mkdir test.log
EXPECTED="error: can't open file test.log for writing"

OUTCOME=$("$gregorio_path" -l test.log test.gabc 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
