if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    eval $gregorio -o "$PWD/kpse_bad_out.file" test.gabc
    [[ $? == "1" ]] || exit 1
else
    exit 0
fi
