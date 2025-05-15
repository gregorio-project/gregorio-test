if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    eval $gregorio -S "$PWD/test.gabc"
    [[ $? == "1" ]] || exit 1
else
    exit 0
fi
