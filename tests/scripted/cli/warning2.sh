EXPECTED="warning: all-warnings option passed several times
error: $gregorio: missing file operand.
Usage: $gregorio [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information."

OUTCOME=$(eval $gregorio -W -W 2>&1)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
