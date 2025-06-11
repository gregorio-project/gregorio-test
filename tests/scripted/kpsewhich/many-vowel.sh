PATH=.:$PATH
export RUNTYPE=many-vowel

EXPECTED=" Looking for notfound in 01.dat
 Could not find notfound in 01.dat
 Looking for notfound in 02.dat
 Could not find notfound in 02.dat
 Looking for notfound in 03.dat
 Could not find notfound in 03.dat
 Looking for notfound in 04.dat
 Could not find notfound in 04.dat
 Looking for notfound in 05.dat
 Could not find notfound in 05.dat
 Looking for notfound in 06.dat
 Could not find notfound in 06.dat
 Looking for notfound in 07.dat
 Could not find notfound in 07.dat
 Looking for notfound in 08.dat
 Could not find notfound in 08.dat
 Looking for notfound in 09.dat
 Could not find notfound in 09.dat
 Looking for notfound in 10.dat
 Could not find notfound in 10.dat
 Looking for notfound in 11.dat
 Could not find notfound in 11.dat
 Looking for notfound in 12.dat
 Could not find notfound in 12.dat
 Looking for notfound in 13.dat
 Could not find notfound in 13.dat
 Looking for notfound in 14.dat
 Could not find notfound in 14.dat
 Looking for notfound in 15.dat
 Could not find notfound in 15.dat
 Looking for notfound in 16.dat
 Could not find notfound in 16.dat
 Looking for notfound in 17.dat
 Could not find notfound in 17.dat
 Looking for notfound in 18.dat
 Could not find notfound in 18.dat
 Looking for notfound in 19.dat
 Could not find notfound in 19.dat
 Looking for notfound in 20.dat
 Could not find notfound in 20.dat
warning:unable to read vowel files for notfound; defaulting to Latin vowel rules
 in voice 1 the first element is a key definition, considered as initial key"

if eval $gregorio -V | grep -q kpathsea
then
    >&2 echo "$gregorio uses the kpathsea libraries"
    >&2 echo "unable to run test many-vowel.sh"
    exit 3
else
    OUTCOME=$(eval $gregorio -v -W test.gabc 2>&1 1> /dev/null)
    
    [[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
fi
