# Gregorio Tests
# Copyright (C) 2015-2016 The Gregorio Project
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

export PASS="${C_GOOD}PASS${C_RESET}"
export FAIL="${C_BAD}FAIL${C_RESET}"
export PDFLATEX='lualatex --shell-escape --debug-format --interaction=scrollmode'

if $use_valgrind
then
    export gregorio='valgrind --leak-check=full --show-leak-kinds=all --log-file="$filename.grind" gregorio'
else
    export gregorio='gregorio'
fi

groups=''

function needs_verification {
    test ! -e "$1.noverify"
}

function register {
    method_missing=false

    for method in test clean accept view_log view_diff view_expected \
        view_output
    do
        if [ "$(type -t ${1}_$method)" != "function" ]
        then
            method_missing=true
            echo "${1}_${method} is not defined in harness.sh"
        fi
    done

    if $method_missing
    then
        exit 100
    fi

    groups="${groups} $1"
    export -f ${1}_test ${1}_clean
}

function testing {
    TESTING="$1"
    RESULTFILE="$2"
    CLEANUP="$3"
}

if $show_success
then
    function pass {
        RESULT=0
        echo "PASS|$TESTING|Pass" > $RESULTFILE
        echo "$TESTING : $PASS"
        if $clean_passed
        then
            eval $CLEANUP
        fi
    }
else
    function pass {
        RESULT=0
        echo "PASS|$TESTING|Pass" > $RESULTFILE
        if $clean_passed
        then
            eval $CLEANUP
        fi
    }
fi

function fail {
    RESULT=1
    echo "FAIL|$TESTING|$1" > $RESULTFILE
    echo "$TESTING : $FAIL - $2"
}

function not_verified {
    RESULT=0
    echo "TEST|$TESTING|Not verified" > $RESULTFILE
    echo "$TESTING : not verified"
}

function maybe_run {
    filename="$1"; shift

    if $verify "$filename"
    then
        if answer=$("$@")
        then
            pass
        else
            fail "Results differ" "$answer"
        fi
    else
        not_verified
    fi
}

function accept_result {
    echo "Accepting $2 as expectation for $1"
    if [[ "$1" = *"_B"* ]]
    then
        # this is a backwards test so it needs to be copied to backwards not tests
        accept_dest="backwards"
    else
        accept_dest="tests"
    fi
    $CP "$2" "$testroot/$accept_dest/$(dirname "$1")/$3"
}

function view_text {
    if [ "$VIEW_TEXT" = "" ]
    then
        echo "Unable to view $1"
        echo 'VIEW_TEXT is not set.'
    elif [ ! -r "$1" ]
    then
        echo "Unable to view $1"
        echo 'File does not exist.'
    else
        cmd="${VIEW_TEXT//\{file\}/$1}"
        echo "$cmd"
        eval $cmd
    fi
}

function view_pdf {
    if [ "$VIEW_PDF" = "" ]
    then
        echo "Unable to view $1"
        echo 'VIEW_PDF is not set.'
    elif [ ! -r "$1" ]
    then
        echo "Unable to view $1"
        echo 'File does not exist.'
    else
        cmd="${VIEW_PDF//\{file\}/$1}"
        echo "$cmd"
        eval $cmd
    fi
}

function view_images {
    if [ "$VIEW_IMAGES" = "" ]
    then
        echo "Unable to view $@"
        echo 'VIEW_IMAGES is not set.'
    elif [ "$#" = "0" -o ! -r "$1" ]
    then
        echo 'No files to view exist.'
    else
        cmd="${VIEW_IMAGES//\{files\}/$@}"
        echo "$cmd"
        eval $cmd
    fi
}

function diff_text {
    if [ "$DIFF_TEXT" = "" ]
    then
        echo "Unable to view $1"
        echo 'DIFF_TEXT is not set.'
    elif [ ! -r "$2" ]
    then
        echo "Unable to diff against $2"
        echo 'File does not exist.'
    else
        cmd="${DIFF_TEXT//\{expect\}/$1}"
        cmd="${cmd//\{output\}/$2}"
        echo "$cmd"
        eval $cmd
    fi
}

function diff_pdf {
    if [ "$DIFF_PDF" = "" ]
    then
        echo "Unable to view $1"
        echo 'DIFF_PDF is not set.'
    elif [ ! -r "$2" ]
    then
        echo "Unable to diff against $2"
        echo 'File does not exist.'
    else
        cmd="${DIFF_PDF//\{expect\}/$1}"
        cmd="${cmd//\{output\}/$2}"
        echo "$cmd"
        eval $cmd
    fi
}

export -f needs_verification testing pass fail not_verified maybe_run

function gabc_gtex_find {
    $FIND gabc-gtex -name '*.gabc' -print
}
function gabc_gtex_test {
    filename="$1"
    outfile="$filename.out"
    logfile="$filename.log"
    expfile="${filename%.gabc}.tex"

    testing "$filename" "$filename.result" "gabc_gtex_clean '$filename'"

    export TEXINPUTS="$(dirname "$filename"):"
    if eval $gregorio -Wv -f gabc -F gtex -o "$outfile" -l "$logfile" "$filename"
    then
        if [[ "$filename" == */should-fail/* ]]
        then
            fail "Did not fail" "$filename should have failed"
        else
            ${SED} -e 's/^\(% File generated by gregorio \).*/\1@/' \
                -e 's/\(\GregorioTeXAPIVersion{\)[^}]\+/\1@/' \
                -e 's/\(\GreBeginScore{\)[^}]\+/\1@/' \
                "$outfile" > "$outfile-"
            $verify "$filename" && ${SED} \
                -e 's/^\(% File generated by gregorio \).*/\1@/' \
                -e 's/\(\GregorioTeXAPIVersion{\)[^}]\+/\1@/' \
                -e 's/\(\GreBeginScore{\)[^}]\+/\1@/' \
                "$expfile" > "$expfile-"
            maybe_run "$filename" diff -q "$outfile-" "$expfile-"
        fi
    else
        if [[ "$filename" == */should-fail/* ]]
        then
            pass
        else
            fail "Failed to compile" "Failed to compile $filename"
        fi
    fi

    return $RESULT
}
function gabc_gtex_clean {
    filename="$1"
    outfile="$filename.out"
    expfile="${filename%.gabc}.tex"

    $RM -f "$filename" "$filename.log" "$outfile" "$outfile-" "$expfile" \
        "$expfile-"
}
function gabc_gtex_accept {
    accept_result "$1" "$1.out" "$(basename "${1%.gabc}").tex"
}
function gabc_gtex_view_log {
    view_text "$1.log"
}
function gabc_gtex_view_diff {
    filename="$1"
    diff_text "${filename%.gabc}.tex-" "$filename.out-"
}
function gabc_gtex_view_expected {
    view_text "${1%.gabc}.tex-"
}
function gabc_gtex_view_output {
    view_text "$filename.out-"
}
register gabc_gtex

function gabc_dump_find {
    $FIND gabc-dump -name '*.gabc' -print
}
function gabc_dump_test {
    filename="$1"
    outfile="$filename.out"
    logfile="$filename.log"
    expfile="${filename%.gabc}.dump"

    testing "$filename" "$filename.result" "gabc_dump_clean '$filename'"

    export TEXINPUTS="$(dirname "$filename"):"
    if eval $gregorio -Wv -f gabc -F dump -o "$outfile" -l "$logfile" "$filename"
    then
        if [[ "$filename" == */should-fail/* ]]
        then
            fail "Did not fail" "$filename should have failed"
        else
            ${SED} -e 's/[0-9]\+\( (\(GRE\|S\|G\|L\|SP\|\)_\)/@\1/' "$outfile" \
                > "$outfile-"
            $verify "$filename" && ${SED} \
                -e 's/[0-9]\+\( (\(GRE\|S\|G\|L\|SP\|\)_\)/@\1/' "$expfile" \
                > "$expfile-"
            maybe_run "$filename" diff -q "$outfile-" "$expfile-"
        fi
    else
        if [[ "$filename" == */should-fail/* ]]
        then
            pass
        else
            fail "Failed to compile" "Failed to compile $filename"
        fi
    fi

    return $RESULT
}
function gabc_dump_clean {
    filename="$1"
    outfile="$filename.out"
    expfile="${filename%.gabc}.dump"

    $RM -f "$filename" "$filename.log" "$outfile" "$outfile-" "$expfile" \
        "$expfile-"
}
function gabc_dump_accept {
    accept_result "$1" "$1.out" "$(basename "${1%.gabc}").dump"
}
function gabc_dump_view_log {
    view_text "$1.log"
}
function gabc_dump_view_diff {
    filename="$1"
    diff_text "${filename%.gabc}.dump-" "$filename.out-"
}
function gabc_dump_view_expected {
    view_text "${1%.gabc}.dump-"
}
function gabc_dump_view_output {
    view_text "$filename.out-"
}
register gabc_dump

function gabc_gabc_find {
    $FIND gabc-gabc -name '*.gabc' -print
}
function gabc_gabc_test {
    filename="$1"
    outfile="$filename.out"
    logfile="$filename.log"
    expfile="${filename%.gabc}.exp"

    testing "$filename" "$filename.result" "gabc_gabc_clean '$filename'"

    export TEXINPUTS="$(dirname "$filename"):"
    if eval $gregorio -Wv -f gabc -F gabc -o "$outfile" -l "$logfile" "$filename"
    then
        if [[ "$filename" == */should-fail/* ]]
        then
            fail "Did not fail" "$filename should have failed"
        else
            ${SED} -e 's/^\(% File generated by gregorio \).*/\1@/' \
                -e 's/^\(generated-by: \).*;$/\1@;/' \
                -e 's/^\(\GregorioTeXAPIVersion{\)[^}]*/\1@/' \
                -e 's/^\(\GreBeginScore{\)[^}]*/\1@/' "$outfile" \
                > "$outfile-"
            $verify "$filename" && ${SED} \
                -e 's/^\(% File generated by gregorio \).*/\1@/' \
                -e 's/^\(generated-by: \).*;$/\1@;/' \
                -e 's/^\(\GregorioTeXAPIVersion{\)[^}]*/\1@/' \
                -e 's/^\(\GreBeginScore{\)[^}]*/\1@/' "$expfile" \
                > "$expfile-"
            maybe_run "$filename" diff -q "$outfile-" "$expfile-"
        fi
    else
        if [[ "$filename" == */should-fail/* ]]
        then
            pass
        else
            fail "Failed to compile" "Failed to compile $filename"
        fi
    fi

    return $RESULT
}
function gabc_gabc_clean {
    filename="$1"
    outfile="$filename.out"
    expfile="${filename%.gabc}.exp"

    $RM -f "$filename" "$filename.log" "$outfile" "$outfile-" "$expfile" \
        "$expfile-"
}
function gabc_gabc_accept {
    accept_result "$1" "$1.out" "$(basename "${1%.gabc}").exp"
}
function gabc_gabc_view_log {
    view_text "$1.log"
}
function gabc_gabc_view_diff {
    filename="$1"
    diff_text "${filename%.gabc}.exp-" "$filename.out-"
}
function gabc_gabc_view_expected {
    view_text "${1%.gabc}.exp-"
}
function gabc_gabc_view_output {
    view_text "$filename.out-"
}
register gabc_gabc

function scripted_find {
    $FIND scripted -name '*.sh' -print
}
function scripted_test {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outfile="${filename%.sh}.log"
    logfile="${filename%.sh}.log"

    testing "$1" "$filename.result" "scripted_clean '$filename'"

    if cd "$indir"
    then
        if bash "$filename" >"$outfile" 2>"$logfile"
        then
            pass
        else
            fail "Failed to compile" "Failed to compile $filename"
        fi
    else
        fail "Failed to create directory" "Could not change to $indir"
    fi

    return $RESULT
}
function scripted_clean {
    true
}
function scripted_accept {
    echo "Nothing to accept"
}
function scripted_view_log {
    view_text "${1%.sh}.log"
}
function scripted_view_diff {
    echo "Nothing to diff"
}
function scripted_view_expected {
    echo "No expectation to view"
}
function scripted_view_output {
    view_text "${1%.sh}.out"
}
register scripted

function typeset_and_compare {
    indir="$1"; shift
    outdir="$1"; shift
    texfile="$1"; shift
    pdffile="${texfile%.tex}.pdf"
    cmdoutfile="${texfile%.tex}.cmdout"

    if "$@" --output-directory="$outdir" "$texfile" >&"$outdir"/"$cmdoutfile"
    then
        if [[ "$indir/" == */should-fail/* ]]
        then
            fail "Did not fail" "$filename should have failed"
        else
            if $verify "$texfile"
            then
                if cd "$outdir" && mkdir expected && \
                    convert -density 150 "../$pdffile" expected/page.png && \
                    convert -density 150 "$pdffile" page.png
                then
                    declare -a failed
                    for name in page*.png
                    do
                        if ! compare -metric AE -fuzz 90% "$name" \
                            "expected/$name" "diff-$name" 2>/dev/null
                        then
                            convert \( -background white -flatten "$name" \) \
                                \( -background white -flatten "expected/$name" \) \
                                \( -clone 0,1 -compose difference -composite \) \
                                \( -clone 0 -clone 2 -compose minus -composite \
                                    -background blue -alpha shape \) \
                                \( -clone 1 -clone 2 -compose minus \
                                    -composite -background red -alpha shape \) \
                                \( -clone 0,1 -fill white -colorize 80% \) \
                                -delete 0-2 -reverse -background white \
                                -compose over -flatten "diff-$name"
                            failed[${#failed[@]}]="$indir/$outdir/$name"
                        fi
                    done
                    if [ ${#failed[@]} != 0 ]
                    then
                        fail "Results differ" "[${failed[*]}] differ from expected"
                        return
                    fi
                    pass
                else
                    fail "Failed to create images" \
                        "Failed to create images for $indir/$outdir/$pdffile"
                fi
            else
                cd "$outdir" && not_verified
            fi
        fi
    else
        if [[ "$indir/" == */should-fail/* ]]
        then
            pass
        else
            fail "Failed to typeset" "Failed to typeset $indir/$outdir/$texfile"
        fi
    fi
}
function clean_typeset_result {
    filename="$1"
    outdir="$filename.out"
    cd ..
    $RM -f "$filename" "${filename%.$2}.pdf"
    if [ -d "$outdir" ]
    then
        $RM -r "$outdir"
    fi
}
function accept_typeset_result {
    filebase="$(basename "$1")"
    filebase="${filebase%.$2}"
    accept_result "$1" "$1.out/$filebase.pdf" "$filebase.pdf"
}
function view_typeset_diff {
    if [ "$DIFF_PDF" = "" ]
    then
        (cd "$1/$2" && view_images diff-page*.png)
    else
        diff_pdf "$1/$3" "$1/$2/$3"
    fi
}
export -f typeset_and_compare clean_typeset_result accept_typeset_result \
    view_typeset_diff

function gabc_output_find {
    $FIND gabc-output -name '*.gabc' -print
}
function gabc_output_test {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"
    filebase="${filename%.gabc}"
    texfile="$filebase.tex"

    testing "$1" "../$filename.result" "gabc_output_clean '$filename'"

    if cd "${indir}" && mkdir "${outdir}"
    then
        if test -z "$GABC_OUTPUT_DEBUG"
        then
            debugarg=''
        else
            debugarg="debug=$GABC_OUTPUT_DEBUG"
        fi
        if [[ "$filename" = *"_B"* ]]
        then
            deprecated="allowdeprecated=true"
        else
            deprecated="allowdeprecated=false"
        fi
        if test -f $filebase-preamble.tex
        then
            preamble="\\\\input{$filebase-preamble.tex}"
        else
            preamble=""
        fi
        if ${SED} -e "s/###FILENAME###/$filebase/" \
            -e "s/###DEPRECATED###/$deprecated/" \
            -e "s/###DEBUG###/$debugarg/" \
            -e "s!###FONTDIR###!$testroot/fonts/!" \
            -e "s/###PREAMBLE###/$preamble/" \
            "$testroot/gabc-output.tex" >${texfile}
        then
            typeset_and_compare "$indir" "$outdir" "$texfile" \
                latexmk -e 'push @generated_exts, "gaux";' -pdf -pdflatex="$PDFLATEX"
        else
            fail "Failed to create TeX file" \
                "Could not create $indir/$outdir/$texfile"
        fi
    else
        fail "Failed to create directory" "Could not create $indir/$outdir"
    fi

    return $RESULT
}
function gabc_output_clean {
    filename="$1"
    filebase="${filename%.gabc}"

    clean_typeset_result "$filename" gabc
    $RM -f "$filebase"-*.gtex "$filebase.tex"
}
function gabc_output_accept {
    accept_typeset_result "$1" gabc
}
function gabc_output_view_log {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"

    view_text "$indir/$outdir/${filename%.gabc}.log"
}
function gabc_output_view_diff {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"

    view_typeset_diff "$indir" "$outdir" "${filename%.gabc}.pdf"
}
function gabc_output_view_expected {
    view_pdf "${1%.gabc}.pdf"
}
function gabc_output_view_output {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"

    view_pdf "$indir/$outdir/${filename%.gabc}.pdf"
}
register gabc_output

function tex_output_find {
    $FIND tex-output -name '*.tex' -print
}
function tex_output_test {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"

    testing "$1" "../$filename.result" "tex_output_clean '$filename'"

    if cd "$indir" && mkdir "$outdir"
    then
        typeset_and_compare "$indir" "$outdir" "$filename" \
            latexmk -e 'push @generated_exts, "gaux";' -pdf -pdflatex="$PDFLATEX"
    else
        fail "Failed to create directory" "Could not create $indir/$outdir"
    fi

    return $RESULT
}
function tex_output_clean {
    clean_typeset_result "$1" tex
}
function tex_output_accept {
    accept_typeset_result "$1" tex
}
function tex_output_view_log {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"

    view_text "$indir/$outdir/${filename%.tex}.log"
}
function tex_output_view_diff {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"

    view_typeset_diff "$indir" "$outdir" "${filename%.tex}.pdf"
}
function tex_output_view_expected {
    view_pdf "${1%.tex}.pdf"
}
function tex_output_view_output {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"

    view_pdf "$indir/$outdir/${filename%.tex}.pdf"
}
register tex_output

function plain_tex_run {
    typeset -i count
    count=0
    while (( ++count <= 5 )) && ( test ! -f "$LOGFILE" || grep -q "Rerun to " "$LOGFILE" )
    do
        echo "=============================================="
        echo "RUN : $count"
        luatex --shell-escape "$@"
    done
    test -f "$LOGFILE" && ! grep -q "Rerun to " "$LOGFILE"
}
export -f plain_tex_run
function plain_tex_find {
    $FIND plain-tex -name '*.tex' -print
}
function plain_tex_test {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"

    testing "$1" "../$filename.result" "plain_tex_clean '$filename'"

    if cd "$indir" && mkdir "$outdir"
    then
        LOGFILE="$outdir/${filename%.tex}.log" typeset_and_compare "$indir" "$outdir" "$filename" plain_tex_run
    else
        fail "Failed to create directory" "Could not create $indir/$outdir"
    fi

    return $RESULT
}
function plain_tex_clean {
    clean_typeset_result "$1" tex
}
function plain_tex_accept {
    accept_typeset_result "$1" tex
}
function plain_tex_view_log {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"

    view_text "$indir/$outdir/${filename%.tex}.log"
}
function plain_tex_view_diff {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"

    view_typeset_diff "$indir" "$outdir" "${filename%.tex}.pdf"
}
function plain_tex_view_expected {
    view_pdf "${1%.tex}.pdf"
}
function plain_tex_view_output {
    indir="$(dirname "$1")"
    filename="$(basename "$1")"
    outdir="$filename.out"

    view_pdf "$indir/$outdir/${filename%.tex}.pdf"
}
register plain_tex
