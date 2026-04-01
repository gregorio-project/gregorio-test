EXPECTED="warning: point-and-click option passed several times
error: $gregorio_name: missing file operand.
Usage: $gregorio_name [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_name --help' for more information."

OUTCOME=$(eval $gregorio -p -p 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
