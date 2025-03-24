if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    eval $gregorio -S test.gabc
    exit $?
else
    exit 2
fi
