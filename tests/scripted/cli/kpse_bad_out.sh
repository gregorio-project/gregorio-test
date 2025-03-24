if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    if eval $gregorio -o "$PWD/kpse_bad_out.file" test.gabc
    then exit 1
    else exit 0
    fi
else
    >&2 echo "$gregorio does not use the kpathsea libraries"
    >&2 echo "unable to run test kpse_bad_out.sh"
    exit 2
fi
