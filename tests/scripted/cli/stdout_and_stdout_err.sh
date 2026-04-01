EXPECTED="warning: option used several times: S
Usage: $gregorio_name [OPTION]... [-s | INPUT_FILE]
Try '$gregorio_name --help' for more information.
Proceeding anyway..."

OUTCOME=$(eval $gregorio -S -S test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
