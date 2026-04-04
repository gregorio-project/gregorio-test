EXPECTED="error: $gregorio_winsafe: missing file operand.
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information."
echo "$EXPECTED" | hexdump -C

echo "=========="
OUTCOME=$("$gregorio_path" 2>&1 | tr -d '\r')
echo "=========="
echo "$OUTCOME" | hexdump -C
echo "=========="

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
