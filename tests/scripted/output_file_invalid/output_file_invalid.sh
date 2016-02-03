mkdir test.dump
if eval $gregorio -F dump test.gabc
then exit 1
else exit 0
fi
