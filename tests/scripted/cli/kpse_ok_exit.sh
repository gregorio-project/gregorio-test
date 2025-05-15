if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    eval $gregorio -S test.gabc
    [[ $? == "0" ]] || exit 1
else
    exit 0
fi
