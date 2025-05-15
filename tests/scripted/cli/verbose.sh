EXPECTED="$gregorio: missing file operand.
Usage: $gregorio [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information."

OUTCOME=$(eval $gregorio -v 2>&1)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
