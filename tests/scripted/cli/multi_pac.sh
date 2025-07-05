EXPECTED="warning: point-and-click option passed several times
error: $gregorio: missing file operand.
Usage: $gregorio [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information."

OUTCOME=$(eval $gregorio -p -p 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
