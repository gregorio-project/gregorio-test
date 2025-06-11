mkdir temp
cd temp
rmdir ../temp
eval $gregorio nonexistent.gabc
[[ $? == "1" ]] || exit 1
