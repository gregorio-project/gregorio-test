EXPECTED="$gregorio_winsafe: invalid option 'Z'
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information."
echo "$EXPECTED" | hexdump -C

echo ==========
OUTCOME=$("$gregorio_path" -Z 2>&1 1> /dev/null | tr -d '\r')
echo ==========
echo "$OUTCOME" | hexdump -C

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
