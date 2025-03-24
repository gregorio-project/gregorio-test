EXPECTEDERR="warning: option used several times: S
Usage: $gregorio [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information.
Proceeding anyway..."

OUTCOMEERR=$(eval $gregorio -S -S test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTEDERR" == "$OUTCOMEERR" ]] || exit 1

source test-gtex.rc

OUTCOMEOUT=$(eval $gregorio -S -S test.gabc)

[[ "$OUTCOMEOUT" =~ $EXPECTEDOUT ]] || exit 1
