EXPECTEDERR="warning: can't write to file and stdout, writing on stdout
Usage: $gregorio [OPTION]... [-s | INPUT_FILE]
Try '$gregorio --help' for more information.
Proceeding anyway..."

OUTCOMEERR=$(eval $gregorio -S -o out.out test.gabc 2>&1 1> /dev/null)

[[ "$EXPECTEDERR" == "$OUTCOMEERR" ]] || exit 1

source test-gtex.rc

OUTCOMEOUT=$(eval $gregorio -S -o out.out test.gabc)

[[ "$OUTCOMEOUT" =~ $EXPECTEDOUT ]] || exit 1
