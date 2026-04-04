EXPECTED="warning: several output files declared, out1.out taken
Usage: $gregorio_winsafe [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_winsafe --help' for more information.
Proceeding anyway..."

OUTCOME=$("$gregorio_path" -o out1.out -o out2.out test.gabc 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
