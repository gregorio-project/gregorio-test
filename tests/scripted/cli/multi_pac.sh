EXPECTED="warning: point-and-click option passed several times
error: $gregorio_winsafe: missing file operand.
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information."

OUTCOME=$("$gregorio_path" -p -p 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
