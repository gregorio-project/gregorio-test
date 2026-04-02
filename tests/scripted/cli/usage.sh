EXPECTED="error: $gregorio_name: missing file operand.
Usage: $gregorio_name [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_name --help' for more information."
echo $EXPECTED | cat -v

OUTCOME=$(eval $gregorio 2>&1 | tr -d '\r')
echo $OUTCOME | cat -v

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
