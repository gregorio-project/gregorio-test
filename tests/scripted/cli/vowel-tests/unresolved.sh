EXPECTED_START=(
    " Looking for unresolved in gregorio-vowels.dat"
    " Aliasing unresolved to notfound"
)

# We don't know how many gregorio-vowels.dat files are installed and we assume that none
# will have rules for a language called notfound.
EXPECTED_MIDDLE_PAIR=(
    " Looking for notfound in gregorio-vowels.dat"
    " Could not find notfound in gregorio-vowels.dat"
)

EXPECTED_END=(
    "warning:Selecting Latin instead of unresolved"
    " in voice 1 the first element is a key definition, considered as initial key"
)

printf '%s\n' "${EXPECTED_START[@]}"
printf '%s\n' "${EXPECTED_MIDDLE_PAIR[@]}"
printf '%s\n' "${EXPECTED_END[@]}"
echo ==========
OUTCOME=$("$gregorio_path" -v -W unresolved.gabc 2>&1 1> /dev/null | tr -d '\r')
echo ==========

# Remove the paths from gregorio-vowels.dat as these may vary by machine
NORMALIZED=$(echo "$OUTCOME" \
    | sed 's|\./gregorio-vowels\.dat|gregorio-vowels.dat|g' \
    | sed 's|[A-Za-z]:[\\/][^ ]*[/\\]gregorio-vowels\.dat|gregorio-vowels.dat|g' \
    | sed 's|/[^ ]*/gregorio-vowels\.dat|gregorio-vowels.dat|g')

echo "$NORMALIZED"

ACTUAL=( )
while IFS= read -r line; do
    ACTUAL+=("$line")
done <<< "$NORMALIZED"

TOTAL=${#ACTUAL[@]}
START=${#EXPECTED_START[@]}
END=${#EXPECTED_END[@]}
MIDDLE_COUNT=$((TOTAL - START - END))

[[ $MIDDLE_COUNT -ge 2 ]] || exit 1
[[ $((MIDDLE_COUNT % 2)) -eq 0 ]] || exit 1

for ((i=0; i<START; i++)); do
    [[ "${ACTUAL[i]}" == "${EXPECTED_START[i]}" ]] || exit 1
done

for ((i=0; i<MIDDLE_COUNT; i+=2)); do
    [[ "${ACTUAL[START+i]}"   == "${EXPECTED_MIDDLE_PAIR[0]}" ]] || exit 1
    [[ "${ACTUAL[START+i+1]}" == "${EXPECTED_MIDDLE_PAIR[1]}" ]] || exit 1
done

for ((i=0; i<END; i++)); do
    [[ "${ACTUAL[TOTAL-END+i]}" == "${EXPECTED_END[i]}" ]] || exit 1
done
