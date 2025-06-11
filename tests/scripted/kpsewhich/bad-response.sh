PATH=.:$PATH
export RUNTYPE=bad-response

EXPECTED="warning:kpsewhich returned bad value for gregorio-vowels.dat
warning:unable to read vowel files for notfound; defaulting to Latin vowel rules"

if eval $gregorio -V | grep -q kpathsea
then
    >&2 echo "$gregorio uses the kpathsea libraries"
    >&2 echo "unable to run test bad-response.sh"
    exit 3
else
    OUTCOME=$(eval $gregorio -W test.gabc 2>&1 1> /dev/null)
    
    [[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
fi
