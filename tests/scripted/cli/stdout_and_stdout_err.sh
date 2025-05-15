EXPECTED="warning: option used several times: S
Usage: $gregorio [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information.
Proceeding anyway..."

OUTCOME=$(eval $gregorio -S -S test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
