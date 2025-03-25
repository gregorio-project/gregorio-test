EXPECTED="error: unknown output format: bad
Usage: gregorio [OPTION]... [-s | INPUT_FILE]
Try 'gregorio --help' for more information."

OUTCOME=$(eval $gregorio -F bad test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
