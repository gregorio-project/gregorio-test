EXPECTED_START=(
    " Looking for primus in gregorio-vowels.dat"
    " Aliasing primus to secundus"
    " Aliasing secundus to tertius"
    " Aliasing tertius to quartus"
    " Aliasing quartus to quintus"
    " Aliasing quintus to sextus"
    " Aliasing sextus to septimus"
    " Aliasing septimus to octavus"
    " Aliasing octavus to nonus"
    " Aliasing nonus to decimus"
    " Aliasing decimus to undecimus"
    " Aliasing undecimus to duodecimus"
    " Aliasing duodecimus to tertius_decimus"
    " Aliasing tertius_decimus to quartus_decimus"
    " Aliasing quartus_decimus to quintus_decimus"
    " Aliasing quintus_decimus to sextus_decimus"
    " Aliasing sextus_decimus to septimus_decimus"
    " Aliasing septimus_decimus to duodevicesimus"
    " Aliasing duodevicesimus to undevicesimus"
    " Aliasing undevicesimus to vicesimus"
    " Aliasing vicesimus to vicesimus_primus"
    " Aliasing vicesimus_primus to vicesimus_secundus"
    " Aliasing vicesimus_secundus to vicesimus_tertius"
    " Aliasing vicesimus_tertius to vicesimus_quartus"
    " Aliasing vicesimus_quartus to vicesimus_quintus"
    " Aliasing vicesimus_quintus to vicesimus_sextus"
    " Aliasing vicesimus_sextus to vicesimus_septimus"
    " Aliasing vicesimus_septimus to vicesimus_octavus"
    " Aliasing vicesimus_octavus to vicesimus_nonus"
    " Aliasing vicesimus_nonus to tricesimus"
    " Aliasing tricesimus to tricesimus_primus"
    " Aliasing tricesimus_primus to tricesimus_secundus"
    " Aliasing tricesimus_secundus to tricesimus_tertius"
    " Aliasing tricesimus_tertius to tricesimus_quartus"
    " Aliasing tricesimus_quartus to tricesimus_quintus"
    " Aliasing tricesimus_quintus to latin"
)

# We don't know how many gregorio-vowels.dat files are installed and we assume that none
# will have custom latin rules.
EXPECTED_MIDDLE_PAIR=(
    " Looking for latin in gregorio-vowels.dat"
    " Could not find latin in gregorio-vowels.dat"
)

EXPECTED_END=(
    " Using default Latin vowel rules"
    " in voice 1 the first element is a key definition, considered as initial key"
)

printf '%s\n' "${EXPECTED_START[@]}"
printf '%s\n' "${EXPECTED_MIDDLE_PAIR[@]}"
printf '%s\n' "${EXPECTED_END[@]}"
echo ==========
OUTCOME=$("$gregorio_path" -v -W primus.gabc 2>&1 1> /dev/null | tr -d '\r')
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
