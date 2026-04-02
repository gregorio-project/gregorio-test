EXPECTED="$gregorio_name: invalid option -- Z
$gregorio_name: invalid option -- Z
error: $gregorio_name: missing file operand.
Usage: $gregorio_name [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information."
echo $EXPECTED | cat -v

OUTCOME=$(eval $gregorio -Z 2>&1 1> /dev/null | tr -d '\r')
echo $OUTCOME | cat -v

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
