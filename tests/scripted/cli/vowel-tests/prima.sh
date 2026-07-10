EXPECTED=" Looking for prima in ./gregorio-vowels.dat
 Aliasing prima to secunda
 Looking for secunda in ./gregorio-vowels.dat
 Aliasing secunda to tertia
 Looking for tertia in ./gregorio-vowels.dat
 Aliasing tertia to quarta
 Looking for quarta in ./gregorio-vowels.dat
 Aliasing quarta to quinta
 Looking for quinta in ./gregorio-vowels.dat
 Aliasing quinta to sexta
 Looking for sexta in ./gregorio-vowels.dat
 Aliasing sexta to septima
 Looking for septima in ./gregorio-vowels.dat
 Aliasing septima to octava
 Looking for octava in ./gregorio-vowels.dat
 Aliasing octava to nona
 Looking for nona in ./gregorio-vowels.dat
 Aliasing nona to decima
 Looking for decima in ./gregorio-vowels.dat
 Aliasing decima to undecima
 Looking for undecima in ./gregorio-vowels.dat
 Aliasing undecima to duodecima
 Looking for duodecima in ./gregorio-vowels.dat
 Aliasing duodecima to tertia_decima
 Looking for tertia_decima in ./gregorio-vowels.dat
 Aliasing tertia_decima to quarta_decima
 Looking for quarta_decima in ./gregorio-vowels.dat
 Aliasing quarta_decima to quinta_decima
 Looking for quinta_decima in ./gregorio-vowels.dat
 Aliasing quinta_decima to sexta_decima
 Looking for sexta_decima in ./gregorio-vowels.dat
 Aliasing sexta_decima to septima_decima
 Looking for septima_decima in ./gregorio-vowels.dat
 Aliasing septima_decima to duodevicesima
 Looking for duodevicesima in ./gregorio-vowels.dat
 Aliasing duodevicesima to undevicesima
 Looking for undevicesima in ./gregorio-vowels.dat
 Aliasing undevicesima to vicesima
 Looking for vicesima in ./gregorio-vowels.dat
 Aliasing vicesima to vicesima_prima
 Looking for vicesima_prima in ./gregorio-vowels.dat
 Aliasing vicesima_prima to vicesima_secunda
 Looking for vicesima_secunda in ./gregorio-vowels.dat
 Aliasing vicesima_secunda to vicesima_tertia
 Looking for vicesima_tertia in ./gregorio-vowels.dat
 Aliasing vicesima_tertia to vicesima_quarta
 Looking for vicesima_quarta in ./gregorio-vowels.dat
 Aliasing vicesima_quarta to vicesima_quinta
 Looking for vicesima_quinta in ./gregorio-vowels.dat
 Aliasing vicesima_quinta to vicesima_sexta
 Looking for vicesima_sexta in ./gregorio-vowels.dat
 Aliasing vicesima_sexta to vicesima_septima
 Looking for vicesima_septima in ./gregorio-vowels.dat
 Aliasing vicesima_septima to vicesima_octava
 Looking for vicesima_octava in ./gregorio-vowels.dat
 Aliasing vicesima_octava to vicesima_nona
 Looking for vicesima_nona in ./gregorio-vowels.dat
 Aliasing vicesima_nona to tricesima
 Looking for tricesima in ./gregorio-vowels.dat
 Aliasing tricesima to tricesima_prima
 Looking for tricesima_prima in ./gregorio-vowels.dat
 Aliasing tricesima_prima to tricesima_secunda
 Looking for tricesima_secunda in ./gregorio-vowels.dat
 Aliasing tricesima_secunda to tricesima_tertia
warning:Alias depth exceeded while resolving prima. Selecting Latin instead
 in voice 1 the first element is a key definition, considered as initial key"

echo "$EXPECTED"
echo ==========
OUTCOME=$("$gregorio_path" -v -W prima.gabc 2>&1 1> /dev/null | tr -d '\r')
echo ==========
echo "$OUTCOME"

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
