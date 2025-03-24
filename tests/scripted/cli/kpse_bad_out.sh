if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    if eval $gregorio -o "$PWD/kpse_bad_out.file" test.gabc
    then exit 1
    else exit 0
    fi
else
    exit 2
fi
