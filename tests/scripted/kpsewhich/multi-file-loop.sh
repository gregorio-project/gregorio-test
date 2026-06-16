PATH=.:$PATH
export RUNTYPE=many-vowel

EXPECTED=" Looking for primus in 01.dat
 Aliasing primus to secundus
 Looking for secundus in 01.dat
 Could not find secundus in 01.dat
 Looking for secundus in 02.dat
 Aliasing secundus to tertius
 Looking for tertius in 01.dat
 Could not find tertius in 01.dat
 Looking for tertius in 02.dat
 Could not find tertius in 02.dat
 Looking for tertius in 03.dat
 Aliasing tertius to quartus
 Looking for quartus in 01.dat
 Could not find quartus in 01.dat
 Looking for quartus in 02.dat
 Could not find quartus in 02.dat
 Looking for quartus in 03.dat
 Could not find quartus in 03.dat
 Looking for quartus in 04.dat
 Aliasing quartus to quintus
 Looking for quintus in 01.dat
 Could not find quintus in 01.dat
 Looking for quintus in 02.dat
 Could not find quintus in 02.dat
 Looking for quintus in 03.dat
 Could not find quintus in 03.dat
 Looking for quintus in 04.dat
 Could not find quintus in 04.dat
 Looking for quintus in 05.dat
 Aliasing quintus to primus
warning:Alias loop detected for primus. Selecting Latin instead
 in voice 1 the first element is a key definition, considered as initial key"

if "$gregorio_path" -V | grep -q kpathsea
then
    >&2 echo "$gregorio uses the kpathsea libraries"
    >&2 echo "unable to run test multi-file-loop.sh"
    exit 3
else
    echo "$EXPECTED"
    echo ==========
    OUTCOME=$("$gregorio_path" -v -W primus.gabc 2>&1 1> /dev/null | tr -d '\r')
    echo ==========
    echo "$OUTCOME"
    
    [[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
fi
