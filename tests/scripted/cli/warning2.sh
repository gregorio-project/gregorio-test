EXPECTED="warning: all-warnings option passed several times
error: $gregorio_name: missing file operand.
Usage: $gregorio_name [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_name --help' for more information."

OUTCOME=$(eval $gregorio -W -W 2>&1 | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
