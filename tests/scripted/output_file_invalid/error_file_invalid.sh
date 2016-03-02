mkdir test.log
if eval $gregorio -l test.log test.gabc
then exit 1
else exit 0
fi
