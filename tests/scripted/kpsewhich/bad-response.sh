PATH=.:$PATH
export RUNTYPE=bad-response

eval $gregorio -W test.gabc
exit $?
