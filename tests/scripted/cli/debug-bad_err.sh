EXPECTED="in function \`check_score_integrity': error:score initial may not be in an elision"

OUTCOME=$(eval $gregorio -d -S bad.gabc 2>&1 1> /dev/null | tr -d '\r')

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
