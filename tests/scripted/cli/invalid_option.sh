EXPECTED="$gregorio: invalid option -- 'Z'
Usage: $gregorio [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information."
echo $EXPECTED

OUTCOME=$(eval $gregorio -Z 2>&1 1> /dev/null)
echo
echo $OUTCOME

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
