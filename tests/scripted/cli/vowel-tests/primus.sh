EXPECTED=" Looking for primus in ./gregorio-vowels.dat
 Aliasing primus to secundus
 Aliasing secundus to tertius
 Aliasing tertius to quartus
 Aliasing quartus to quintus
 Aliasing quintus to sextus
 Aliasing sextus to septimus
 Aliasing septimus to octavus
 Aliasing octavus to nonus
 Aliasing nonus to decimus
 Aliasing decimus to undecimus
 Aliasing undecimus to duodecimus
 Aliasing duodecimus to tertius_decimus
 Aliasing tertius_decimus to quartus_decimus
 Aliasing quartus_decimus to quintus_decimus
 Aliasing quintus_decimus to sextus_decimus
 Aliasing sextus_decimus to septimus_decimus
 Aliasing septimus_decimus to duodevicesimus
 Aliasing duodevicesimus to undevicesimus
 Aliasing undevicesimus to vicesimus
 Aliasing vicesimus to vicesimus_primus
 Aliasing vicesimus_primus to vicesimus_secundus
 Aliasing vicesimus_secundus to vicesimus_tertius
 Aliasing vicesimus_tertius to vicesimus_quartus
 Aliasing vicesimus_quartus to vicesimus_quintus
 Aliasing vicesimus_quintus to vicesimus_sextus
 Aliasing vicesimus_sextus to vicesimus_septimus
 Aliasing vicesimus_septimus to vicesimus_octavus
 Aliasing vicesimus_octavus to vicesimus_nonus
 Aliasing vicesimus_nonus to tricesimus
 Aliasing tricesimus to tricesimus_primus
 Aliasing tricesimus_primus to tricesimus_secundus
 Aliasing tricesimus_secundus to tricesimus_tertius
 Aliasing tricesimus_tertius to tricesimus_quartus
 Aliasing tricesimus_quartus to tricesimus_quintus
 Aliasing tricesimus_quintus to latin
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
OUTCOME=$("$gregorio_path" -v -W primus.gabc 2>&1 1> /dev/null | tr -d '\r')
echo ==========
echo "$OUTCOME"

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
