EXPECTED=" Looking for first in ./gregorio-vowels.dat
 Aliasing first to second
 Aliasing second to first
 Aliased to first in ./gregorio-vowels.dat
 Looking for first in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 Aliased to first in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 Looking for first in /usr/local/texlive/2026/texmf-dist/tex/luatex/gregoriotex/gregorio-vowels.dat
 Aliased to first in /usr/local/texlive/2026/texmf-dist/tex/luatex/gregoriotex/gregorio-vowels.dat
 Looking for first in ./gregorio-vowels.dat
 Aliasing first to second
 Aliasing second to first
 Aliased to first in ./gregorio-vowels.dat
 Looking for first in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 Aliased to first in /usr/local/texlive/texmf-local/tex/luatex/gregoriotex/gregorio-vowels.dat
 Looking for first in /usr/local/texlive/2026/texmf-dist/tex/luatex/gregoriotex/gregorio-vowels.dat
 Aliased to first in /usr/local/texlive/2026/texmf-dist/tex/luatex/gregoriotex/gregorio-vowels.dat
warning:Unable to resolve alias for first. Selecting Latin instead
 in voice 1 the first element is a key definition, considered as initial key"

echo "$EXPECTED"
echo ==========
OUTCOME=$("$gregorio_path" -v -W circular.gabc 2>&1 1> /dev/null | tr -d '\r')
echo ==========
echo "$OUTCOME"

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
