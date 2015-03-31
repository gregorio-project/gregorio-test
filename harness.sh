# Gregorio Tests
# Copyright (C) 2015 Gregorio Team
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

groups=''

function register {
	groups="${groups} $1"
	export -f ${1}_test ${1}_accept
}

function testing {
	TESTING="$1"
}

function pass {
	RESULT=0
	echo "$TESTING : $PASS"
}

function fail {
	RESULT=1
	echo "$TESTING : $FAIL - $1"
}

function not_verified {
	RESULT=0
	echo "$TESTING : not verified"
}

function maybe_run {
	if $verify
	then
		if answer=$("$@")
		then
			pass
		else
			fail "$answer"
		fi
	else
		not_verified
	fi
}

function accept_result {
	echo "Accepting $2 as expectation for $1"
	cp "$2" "$testroot/tests/$(dirname "$1")/$3"
}

export -f testing pass fail not_verified maybe_run accept_result

function gabc_gtex_find {
	find gabc-gtex -name '*.gabc' -print
}
function gabc_gtex_test {
	filename="$1"
	outfile="${filename}.out"
	logfile="${filename}.log"
	expfile="${filename%.gabc}.tex"

	testing "$filename"

	if gregorio -f gabc -F gtex -o "$outfile" -l "$logfile" "$filename"
	then
        tail -n +3 "$outfile" > "$outfile-"
        tail -n +3 "$expfile" > "$expfile-"
		maybe_run diff -q "$outfile-" "$expfile-"
	else
		fail "Failed to compile $filename"
	fi

	return $RESULT
}
function gabc_gtex_accept {
accept_result "$1" "$1.out" "$(basename "${1%.gabc}").tex"
}
register gabc_gtex

function gabc_dump_find {
	find gabc-dump -name '*.gabc' -print
}
function gabc_dump_test {
	filename="$1"
	outfile="${filename}.out"
	logfile="${filename}.log"
	expfile="${filename%.gabc}.dump"

	testing "$filename"

	if gregorio -f gabc -F dump -o "$outfile" -l "$logfile" "$filename"
	then
        sed -e 's/[0-9]\+\( (\(GRE\|S\)_\)/@\1/' "$outfile" > "$outfile-"
        sed -e 's/[0-9]\+\( (\(GRE\|S\)_\)/@\1/' "$expfile" > "$expfile-"
        maybe_run diff -q "$outfile-" "$expfile-"
	else
		fail "Failed to compile $filename"
	fi

	return $RESULT
}
function gabc_dump_accept {
	accept_result "$1" "$1.out" "$(basename "${1%.gabc}").dump"
}
register gabc_dump

function typeset_and_compare {
	indir="$1"
	outdir="$2"
	texfile="$3"
	pdffile="${texfile%.tex}.pdf"

	if latexmk -pdf -pdflatex='lualatex --shell-escape' --output-directory="$outdir" "$texfile" >&/dev/null
	then
		if $verify
		then
			if cd "$outdir" && mkdir expected && convert "../$pdffile" expected/page.png && convert "$pdffile" page.png
			then
				for name in page*.png
				do
					if ! compare -metric AE "$name" "expected/$name" "diff-$name" 2>/dev/null
					then
						fail "$indir/$outdir/$name differs from expected"
						return
					fi
				done
				pass
			else
				fail "Failed to create images for $indir/$outdir/$pdffile"
			fi
		else
			not_verified
		fi
	else
		fail "Failed to typeset $indir/$outdir/$texfile"
	fi
}
function accept_typeset_result {
	filebase="$(basename "$1")"
	filebase="${filebase%.$2}"
	accept_result "$1" "$(dirname "$1")/$filebase.out/$filebase.pdf" "$filebase.pdf"
}
export -f typeset_and_compare accept_typeset_result

function gabc_output_find {
	find gabc-output -name '*.gabc' -print
}
function gabc_output_test {
	indir="$(dirname "$1")"
	filename="$(basename "$1")"
	filebase="${filename%.gabc}"
	outdir="$filebase.out"
	texfile="$filebase.tex"

	testing "$1"

	if cd "${indir}" && mkdir "${outdir}"
	then
		if sed -e "s/###FILENAME###/$filebase/" "$testroot/gabc-output.tex" >${texfile}
		then
			typeset_and_compare "$indir" "$outdir" "$texfile"
		else
			fail "Could not create $indir/$outdir/$texfile"
		fi
	else
		fail "Could not create $indir/$outdir"
	fi

	return $RESULT
}
function gabc_output_accept {
	accept_typeset_result "$1" gabc
}
register gabc_output

function tex_output_find {
	find tex-output -name '*.tex' -print
}
function tex_output_test {
	indir="$(dirname "$1")"
	filename="$(basename "$1")"
	outdir="${filename%.tex}.out"

	testing "$1"

	if cd "$indir" && mkdir "$outdir"
	then
		typeset_and_compare "$indir" "$outdir" "$filename"
	else
		fail "Could not create $indir/$outdir"
	fi

	return $RESULT
}
function tex_output_accept {
	accept_typeset_result "$1" tex
}
register tex_output
