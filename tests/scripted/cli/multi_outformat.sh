EXPECTED="warning: several output formats declared, first taken
warning: several output formats declared, first taken
Usage: $gregorio_name [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_name --help' for more information.
Proceeding anyway...
error: refusing to overwrite the input file"

OUTCOME=$(eval $gregorio -F gabc -F dump -F gtex test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
