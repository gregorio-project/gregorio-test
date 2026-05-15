EXPECTED=" Looking for anglais in ./gregorio-vowels.dat
 Aliasing anglais to english
 Looking for english in ./gregorio-vowels.dat
 Could not find english in ./gregorio-vowels.dat
 Looking for english in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 Aliasing english to en
 Found en in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 in voice 1 the first element is a key definition, considered as initial key"

echo "$EXPECTED"
echo ==========
OUTCOME=$("$gregorio_path" -v -W anglais.gabc 2>&1 1> /dev/null | tr -d '\r')
echo ==========
echo "$OUTCOME"

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
