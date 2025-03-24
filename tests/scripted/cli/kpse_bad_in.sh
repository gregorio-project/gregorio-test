if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    if eval $gregorio -S "$PWD/test.gabc"
    then exit 1
    else exit 0
    fi
else
    exit 2
fi
