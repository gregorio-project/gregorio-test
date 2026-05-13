EXPECTED=" Looking for unresolved in ./gregorio-vowels.dat
 Aliasing unresolved to notfound
 Aliased to notfound in ./gregorio-vowels.dat
 Looking for notfound in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 Aliased to notfound in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 Looking for notfound in /usr/local/texlive/2026/texmf-dist/tex/luatex/gregoriotex/gregorio-vowels.dat
 Aliased to notfound in /usr/local/texlive/2026/texmf-dist/tex/luatex/gregoriotex/gregorio-vowels.dat
 Looking for notfound in ./gregorio-vowels.dat
 Aliased to notfound in ./gregorio-vowels.dat
 Looking for notfound in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 Aliased to notfound in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 Looking for notfound in /usr/local/texlive/2026/texmf-dist/tex/luatex/gregoriotex/gregorio-vowels.dat
 Aliased to notfound in /usr/local/texlive/2026/texmf-dist/tex/luatex/gregoriotex/gregorio-vowels.dat
warning:Unable to resolve alias for unresolved. Selecting Latin instead
 in voice 1 the first element is a key definition, considered as initial key"

echo "$EXPECTED"
echo ==========
OUTCOME=$("$gregorio_path" -v -W unresolved.gabc 2>&1 1> /dev/null | tr -d '\r')
echo ==========
echo "$OUTCOME"

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
