EXPECTEDERR="warning: option used several times: s
Usage: $gregorio [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information.
Proceeding anyway..."

OUTCOMEERR=$(cat test.gabc | eval $gregorio -s -s 2>&1 1> /dev/null)

[[ "$EXPECTEDERR" == "$OUTCOMEERR" ]] || exit 1

source test-gtex.rc

OUTCOMEOUT=$(cat test.gabc | eval $gregorio -s -s)

[[ "$OUTCOMEOUT" =~ $EXPECTEDOUT ]] || exit 1
