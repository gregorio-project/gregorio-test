EXPECTED="warning: can't write to file and stdout, writing on stdout
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information.
Proceeding anyway..."

OUTCOME=$("$gregorio_path" -S -o out.out test.gabc 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
