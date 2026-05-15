EXPECTED=" Looking for latina in ./gregorio-vowels.dat
 Aliasing latina to latin
 Looking for latin in ./gregorio-vowels.dat
 Could not find latin in ./gregorio-vowels.dat
 Looking for latin in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 Could not find latin in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 Looking for latin in /usr/local/texlive/2026/texmf-dist/tex/luatex/gregoriotex/gregorio-vowels.dat
 Could not find latin in /usr/local/texlive/2026/texmf-dist/tex/luatex/gregoriotex/gregorio-vowels.dat
 Using default Latin vowel rules
 in voice 1 the first element is a key definition, considered as initial key"

echo "$EXPECTED"
echo ==========
OUTCOME=$("$gregorio_path" -v -W latina.gabc 2>&1 1> /dev/null | tr -d '\r')
echo ==========
echo "$OUTCOME"

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
