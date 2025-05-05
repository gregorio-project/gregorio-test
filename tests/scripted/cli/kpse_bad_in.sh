if eval $gregorio -V | grep -q kpathsea
then
    export TEXMFCNF="$PWD:"
    if eval $gregorio -S "$PWD/test.gabc"
    then exit 1
    else exit 0
    fi
else
    >&2 echo "$gregorio does not use the kpathsea libraries"
    >&2 echo "unable to run test kpse_bad_in.sh"
    exit 2
fi
