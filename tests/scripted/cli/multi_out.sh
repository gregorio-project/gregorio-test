EXPECTED="warning: several output files declared, out1.out taken
Usage: $gregorio_name [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_name --help' for more information.
Proceeding anyway..."

OUTCOME=$(eval $gregorio -o out1.out -o out2.out test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
