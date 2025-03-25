if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    source test-gtex.rc
    
    OUTCOME=$($gregorio -S test.gabc)
    
    [[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
else
    exit 0
fi
