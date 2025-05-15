PATH=.:$PATH
export RUNTYPE=bad-response

if eval $gregorio -V | grep -q kpathsea
then
    >&2 echo "$gregorio uses the kpathsea libraries"
    >&2 echo "unable to run test bad-response_exit.sh"
    exit 3
else
    eval $gregorio -W test.gabc
    [[ $? == "0" ]] || exit 1
fi
