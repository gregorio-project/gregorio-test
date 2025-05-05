if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    EXPECTED="error:kpse prohibits read from file $PWD/test.gabc"
    
    OUTCOME=$(eval $gregorio -S "$PWD/test.gabc" 2>&1 1> /dev/null)
    
    [[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
else
    >&2 echo "$gregorio does not use the kpathsea libraries"
    >&2 echo "unable to run test kpse_bad_in.sh"
    exit 2
fi
