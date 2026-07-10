EXPECTED=" Looking for first in ./gregorio-vowels.dat
 Aliasing first to second
 Looking for second in ./gregorio-vowels.dat
 Aliasing second to first
 Aliasing first to second
warning:Alias loop detected for first. Selecting Latin instead
 in voice 1 the first element is a key definition, considered as initial key"

echo "$EXPECTED"
echo ==========
OUTCOME=$("$gregorio_path" -v -W circular.gabc 2>&1 1> /dev/null | tr -d '\r')
echo ==========
echo "$OUTCOME"

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
