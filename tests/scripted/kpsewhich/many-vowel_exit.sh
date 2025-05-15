PATH=.:$PATH
export RUNTYPE=many-vowel

if eval $gregorio -V | grep -q kpathsea
then
    >&2 echo "$gregorio uses the kpathsea libraries"
    >&2 echo "unable to run test many-vowel_exit.sh"
    exit 3
else
    eval $gregorio -v -W test.gabc
    [[ $? == "0" ]] || exit 1
fi
