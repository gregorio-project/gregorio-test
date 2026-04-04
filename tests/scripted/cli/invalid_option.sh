EXPECTED="$gregorio: invalid option -- Z
$gregorio: invalid option -- Z
error: $gregorio_winsafe: missing file operand.
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information."
echo $EXPECTED | cat -v

OUTCOME=$("$gregorio_path" -Z 2>&1 1> /dev/null | tr -d '\r')
echo $OUTCOME | cat -v

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
