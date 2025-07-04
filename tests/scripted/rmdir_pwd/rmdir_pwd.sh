mkdir temp
cd temp
rmdir ../temp
EXPECTED="error: can't determine current directory"

OUTCOME=$(eval $gregorio nonexistent.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1

