if "$gregorio_path" -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    source test-gtex.rc
    
    OUTCOME=$("$gregorio_path" -S test.gabc | tr -d '\r')
    
    [[ "$OUTCOME" =~ $EXPECTED ]] || exit 1
else
    >&2 echo "$gregorio does not use the kpathsea libraries"
    >&2 echo "unable to run test kpse_ok.sh"
    exit 2
fi
