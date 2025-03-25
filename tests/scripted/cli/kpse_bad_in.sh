if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    EXPECTED="error:kpse prohibits read from file $PWD/test.gabc"
    
    OUTCOME=$(eval $gregorio -S "$PWD/test.gabc" 2>&1 1> /dev/null)
    
    [[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
else
    exit 0
fi
