EXPECTEDOUT="Gregorio 6.0.0.
Copyright (C) 2006-2021 Gregorio Project authors (see CONTRIBUTORS.md)
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law."

OUTCOMEOUT=$(eval $gregorio -V)
OUTCOMEOUT=$(sed '1 s/ (.*)//g' <<<$OUTCOMEOUT) #remove kpathsea version info
OUTCOMEOUT=$(sed '1 s/-[^.]*//' <<<$OUTCOMEOUT) #remove git commit info

[[ "$EXPECTEDOUT" == "$OUTCOMEOUT" ]] || exit 1
