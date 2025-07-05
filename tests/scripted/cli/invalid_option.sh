EXPECTED="$gregorio: invalid option -- Z
$gregorio: invalid option -- Z
error: $gregorio: missing file operand.
Usage: $gregorio [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information."

OUTCOME=$(eval $gregorio -Z 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
