EXPECTED="warning: several output formats declared, first taken
warning: several output formats declared, first taken
Usage: $gregorio [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information.
Proceeding anyway...
error: refusing to overwrite the input file"

OUTCOME=$(eval $gregorio -F gabc -F dump -F gtex test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
