#!/usr/bin/env bash

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

# Settings in gregorio-test.rc:
# COLOR         boolean  whether to use color by default
# CLEAN_PASSED  boolean  whether to delete the output files of passed tests
# PROGRESS_BAR  boolean  whether to show a progress bar by default
# SED           string   the command to use for sed; defaults to "sed".
# VIEW_TEXT     string   the command to use to view a text file; expands {file}
#                        into the filename of the text file
# VIEW_PDF      string   the command to use to view a PDF file; expands {file}
#                        into the filename of the PDF file.
# VIEW_IMAGES   string   the command to use to view image files; expands
#                        {files} into the filenames of the image files.
# DIFF_TEXT     string   the command to use for a textual diff; expands
#                        {expect} into the filename of the expected result
#                        filename and {output} into the filename of the actual
#                        result.
# DIFF_PDF      string   the command to use for a PDF diff; expands {expect}
#                        into the filename of the expected result and {output}
#                        into the filename of the actual result.
# PDF_DENSITY   integer  the dpi to use for the pdf comparison.
# SKIP_TESTS    array    tests to skip

# for predictability in parsing results
export LC_ALL=C

export testroot="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
cd "$testroot"

VIEW_TEXT="cat {file}"
DIFF_TEXT="diff {expect} {output}"

rcfile=gregorio-test.rc
if [ -f $rcfile -a -r $rcfile ]
then
    source $rcfile
fi

export SED="${SED:-sed}" CP="${CP:-cp}" RM="${RM:-rm}"
export FIND="${FIND:-find}" XARGS="${XARGS:-xargs}"

case "$(echo $COLOR | tr '[:upper:]' '[:lower:]')" in
t|true|y|yes)
    color=true
    ;;
*)
    color=false
    ;;
esac

case "$(echo $CLEAN_PASSED | tr '[:upper:]' '[:lower:]')" in
t|true|y|yes)
    clean_passed=true
    ;;
*)
    clean_passed=false
    ;;
esac

case "$(echo $PROGRESS_BAR | tr '[:upper:]' '[:lower:]')" in
t|true|y|yes)
    progress_bar=true
    ;;
*)
    progress_bar=false
    ;;
esac

usage=false
verify=needs_verification
mode=test
show_success=false
long_tests=false
use_valgrind=false
declare -A tests_to_run
while (( $# > 0 ))
do
    unset OPTIND
    while getopts ":acCdD:eg:GhlLnPrSv" opt
    do
        case $opt in
        a)
            mode=accept
            ;;
        c)
            if $clean_passed
            then
                clean_passed=false
            else
                clean_passed=true
            fi
            ;;
        C)
            if $color
            then
                color=false
            else
                color=true
            fi
            ;;
        d)
            mode=view_diff
            ;;
        D)
            export GABC_OUTPUT_DEBUG="$OPTARG"
            ;;
        e)
            mode=view_expected
            ;;
        g)
            gregorio_dir="$(realpath "$OPTARG")"
            ;;
        G)
            use_valgrind=true
            ;;
        h)
            usage=true
            ;;
        l)
            mode=view_log
            ;;
        L)
            long_tests=true
            ;;
        n)
            verify=false
            ;;
        P)
            if $progress_bar
            then
                progress_bar=false
            else
                progress_bar=true
            fi
            ;;
        r)
            mode=retest
            if [ -d output ]
            then
                for test in $($FIND output -name '*.result' -print0 |
                    $XARGS -0 grep -h '^FAIL|' | cut -d'|' -f2)
                do
                    no_failed_tests=false
                    tests_to_run[$test]=1
                done
            fi
            ;;
        S)
            show_success=true
            ;;
        v)
            mode=view_output
            ;;
        \?)
            echo "Unknown option: -$OPTARG" >&2
            echo "(use $0 -h for help)" >&2
            exit 2
            ;;
        :)
            echo "Option -$OPTARG is missing its required argument." >&2
            echo "(use $0 -h for help)" >&2
            exit 2
            ;;
        esac
    done
    shift $((OPTIND - 1))

    if (( $# > 0 ))
    then
        if [ "$1" != "" ]
        then
            # strip these off in case the user is using tab-completion
            case "$1" in
                tests/*)
                    arg="${1#tests/}"
                    ;;
                longtests/*)
                    arg="${1#longtests/}"
                    long_tests=true
                    ;;
                output/*)
                    arg="${1#output/}"
                    ;;
                backwards/*)
                    arg="${1#backwards/}"
                    ;;
                *)
                    arg="$1"
                    ;;
            esac

            tests_to_run[$arg]=1
        fi
        shift
    fi
done

if $usage
then
    cat <<EOT
Usage: $0 [OPTION]... [TEST]...

Runs the Gregorio test suite.  If no TEST is specified, all tests will run.

Options:

  -g GREGORIO_DIR   specifies the directory containing a not-installed
                    version of Gregorio.  For this script to be able to use
                    a not-installed Gregorio, the gregorio executable must
                    be linked statically.

  -D CATEGORIES     specifies a comma-separated list of debug message
                    categories to log when running gabc-output tests.  May also
                    be set by the GABC_OUTPUT_DEBUG environment variable.

  -r                rerun failed tests from the previous run.

  -n                runs the tests without verifying results.  Useful (in
                    conjunction with -a) for generating the initial result
                    of a new test to use as future expectation.

  -a                accepts the result of each given TEST.  Makes the result
                    into the future expectation.  Requires that at least one
                    TEST be specified.  Don't forget to add/commit the change!

  -l                views the log of the given TEST.

  -L                includes long tests.

  -G                uses valgrind to check gregorio for memory leaks.  This
                    option will produce {filename}.grind files for the tests
                    that run gregorio directly.  The detection of a memory leak
                    does not affect the pass/fail status of a test.

  -e                views the expected result of the given TEST.

  -v                views the output of the given TEST.

  -d                views the differences between the expected result and the
                    output of the given TEST.

  -C                toggles the use of color.

  -c                toggles the clean-up of passed tests.

  -P                toggles the display of a progress bar.

  -S                show successful tests.  Default is to show only failed
                    tests.

  -h                shows this usage message.

Note: The -a, -l, -e, -v, and -d options are mutually exclusive and will not
      work properly until after the desired test(s) are run.
EOT
    exit 2
fi

export verify clean_passed

if $color
then
    C_BAD="$(tput bold 2>/dev/null; tput setaf 1 2>/dev/null)"
    C_GOOD="$(tput bold 2>/dev/null; tput setaf 2 2>/dev/null)"
    C_RESET="$(tput sgr0 2>/dev/null)"
fi

declare -A tests_to_skip
typeof_SKIP_TESTS="$(declare -p SKIP_TESTS 2>/dev/null)"
if [[ "$typeof_SKIP_TESTS" = 'declare -a '* ]]
then
    for t in $SKIP_TESTS
    do
        tests_to_skip[$t]=1
    done
elif [[ "$typeof_SKIP_TESTS" = 'declare -- '* ]]
then
    tests_to_skip[$SKIP_TESTS]=1
fi

source harness.sh

if [ ! -d tests ]
then
    echo "No tests to run."
    exit 3
fi

if [ "${#tests_to_run[@]}" = 0 ]
then
    case "$mode" in
    accept)
        echo "At least one TEST to accept must be specified." >&2
        echo "(use $0 -h for help)" >&2
        exit 4
        ;;
    view_*)
        echo "Exactly one TEST for viewing results must be specified." >&2
        echo "(use $0 -h for help)" >&2
        exit 5
        ;;
    esac

    function filter {
        while read line
        do
            if [ "${tests_to_skip[$line]}" != "1" ]
            then
                echo $line
            fi
        done
    }
else
    case "$mode" in
    view_*)
        if [ "${#tests_to_run[@]}" != 1 ]
        then
            echo "Only one TEST for viewing results may be specified." >&2
            echo "(use $0 -h for help)" >&2
            exit 6
        fi
        ;;
    esac

    function filter {
        while read line
        do
            if [ "${tests_to_run[$line]}" = "1" -a "${tests_to_skip[$line]}" != "1" ]
            then
                echo $line
            fi
        done
    }
fi

case "$mode" in
test|retest)
    if [ "$mode" = "retest" -a "${#tests_to_run[@]}" = 0 ]
    then
        echo "No tests to re-run."
        exit 7
    fi

    $RM -fr output
    $CP -Lr tests output
    $long_tests && $CP -Lr longtests/* output
    $CP -Lr backwards/* output

    if [ "$gregorio_dir" = "" ]
    then
        gregorio_version=$(grep 'local gregorio_exe ' $(kpsewhich gregoriotex.lua))
        gregorio_version=${gregorio_version#*\'gregorio-}
        gregorio_version=${gregorio_version%\'*}
    else
        if [ ! -f "$gregorio_dir/.gregorio-version" -o \
            ! -r "$gregorio_dir/.gregorio-version" ]
        then
            echo "$gregorio_dir/.gregorio-version is not readable" >&2
            exit 8
        fi

        gregorio_version="$(head -n 1 $gregorio_dir/.gregorio-version)"
        gregorio_version="${gregorio_version//./_}"

        if [ ! -f "$gregorio_dir/src/gregorio-${gregorio_version}" -o \
            ! -x "$gregorio_dir/src/gregorio-${gregorio_version}" ]
        then
            echo "$gregorio_dir/src/gregorio is not an executable" >&2
            exit 8
        fi

        echo "Preparing to use Gregorio from $gregorio_dir"

        export PATH="$gregorio_dir/src:$PATH"

        mkdir -p var/texmf var/texmf-config var/texmf-var
        export TEXMFHOME=$(realpath var/texmf)
        export TEXMFCONFIG=$(realpath var/texmf-config)
        export TEXMFVAR=$(realpath var/texmf-var)

        if ! (cd "$gregorio_dir" && TEXHASH="texhash $TEXMFHOME" \
            CP="rsync -Lci" SKIP=docs,examples,font-sources \
            GENERATE_UNINSTALL=false ./install-gtex.sh user)
        then
            echo "Unable to install GregorioTeX to $TEXMFHOME" >&2
            exit 8
        fi

        echo
    fi

    export gregorio=gregorio-$gregorio_version

    if ! gregorio -F dump -S -s </dev/null 2>/dev/null | grep -q 'SCORE INFOS'
    then
        echo "Gregorio is not installed properly or is not statically linked" >&2
        echo "When building, use ./configure --enable-all-static" >&2
        exit 8
    fi

    echo "Gregorio = $(which $gregorio)"
    echo "GregorioTeX = $(kpsewhich gregoriotex.tex)"
    echo

    processors=$(nproc 2>/dev/null || echo 1)
    cd output
    if $progress_bar
    then
        total=$(
            for group in ${groups}
            do
                ${group}_find | filter
            done | wc -l
        )
        function progress {
            # adapted from http://stackoverflow.com/questions/238073
            let percent=$(((${1}*100/$total*100)/100))
            let completed=$(((${percent}*5)/10))
            let remaining=$((50-$completed))
            fill=$(printf "%${completed}s")
            empty=$(printf "%${remaining}s")
            printf "Processed %3d%% [%s%s] %d/%d\r" $percent "${fill// /#}" "${empty// /_}" $count $total
        }
    fi
    (
        overall_result=0
        time for group in ${groups}
        do
            if ! ${group}_find | filter | $XARGS -P $processors -n 1 -I{} bash -c "${group}_test"' "$@"' _ {} \;
            then
                overall_result=1
            fi
            if $progress_bar
            then
                count=$($FIND . -name '*.result' | wc -l)
                progress $count
            fi
        done
        exit $overall_result
    ) &
    if $progress_bar
    then
        count=0
        while [ $count -lt $total ]
        do
            progress $count
            sleep 1
            count=$($FIND . -name '*.result' | wc -l)
        done
    fi
    wait $!
    overall_result=$?

    $FIND . -name '*.result' -exec cat {} + | {
        total_count=0
        declare -A result_counts
        old_IFS="$IFS"
        IFS="|"
        while read result file message
        do
            ((++result_counts[$message]))
            ((++total_count))
        done
        IFS="$old_IFS"
        echo
        echo "SUMMARY"
        echo "======="
        for message in "${!result_counts[@]}"
        do
            echo "$message" : "${result_counts[$message]}/$total_count"
        done
    }

    echo

    if [ ${overall_result} != 0 ]
    then
        echo "${C_BAD}SOMETHING FAILED${C_RESET}"
        exit 1
    fi

    echo "${C_GOOD}ALL PASS${C_RESET}"
    ;;
accept|view_*)
    cd output
    for group in ${groups}
    do
        # this silliness is so that the command gets the tty of this script
        IFS=$'\r\n' GLOBIGNORE='*' :; filenames=( $(${group}_find | filter) )
        if [ "${#filenames[@]}" -gt 0 ]
        then
            for filename in "${filenames[@]}"
            do
                "${group}_$mode" "$filename"
            done
        fi
    done
    ;;
esac
exit 0
