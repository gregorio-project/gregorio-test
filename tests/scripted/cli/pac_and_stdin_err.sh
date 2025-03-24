EXPECTED="warning: disabling point-and-click since reading from stdin"

OUTCOME=$(cat test.gabc | eval $gregorio -s -p 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
