EXPECTED="error: refusing to overwrite the input file"

OUTCOME=$(eval $gregorio clobber.gtex 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
