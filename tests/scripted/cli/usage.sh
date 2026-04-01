EXPECTED="error: $gregorio_name: missing file operand.
Usage: $gregorio_name [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_name --help' for more information."

OUTCOME=$(eval $gregorio 2>&1)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
