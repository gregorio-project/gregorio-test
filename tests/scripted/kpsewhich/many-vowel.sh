PATH=.:$PATH
export RUNTYPE=many-vowel

eval $gregorio -W test.gabc
exit $?
