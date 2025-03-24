if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    eval $gregorio -S test.gabc
    exit $?
else
    >&2 echo "$gregorio does not use the kpathsea libraries"
    >&2 echo "unable to run test kpse_ok.sh"
    exit 2
fi
