EXPECTED="warning: disabling point-and-click since reading from stdin"

OUTCOME=$(cat test.gabc | "$gregorio_path" -s -p 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
