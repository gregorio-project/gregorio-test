PATH=.:$PATH
export RUNTYPE=bad-response

EXPECTED="warning:kpsewhich returned bad value for gregorio-vowels.dat
warning:Selecting Latin instead of notfound"

if "$gregorio_path" -V | grep -q kpathsea
then
    >&2 echo ""$gregorio_path" uses the kpathsea libraries"
    >&2 echo "unable to run test bad-response.sh"
    exit 3
else
    echo "$EXPECTED"
    echo ==========
    OUTCOME=$("$gregorio_path" -W test.gabc 2>&1 1> /dev/null | tr -d '\r')
    echo ==========
    echo "$OUTCOME"
    
    [[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
fi
