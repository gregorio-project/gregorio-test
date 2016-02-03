mkdir temp
cd temp
rmdir ../temp
if eval $gregorio nonexistent.gabc
then exit 1
else exit 0
fi

