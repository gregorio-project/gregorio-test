EXPECTED="error: $gregorio_winsafe: missing file operand.
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information."

OUTCOME=$("$gregorio_path" -W 2>&1 | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
