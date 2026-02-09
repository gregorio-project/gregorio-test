#!/bin/sh

lualatex --shell-escape --interaction=nonstopmode --recorder PopulusSion
EXPECTED="INPUT PopulusSion.gabc
OUTPUT PopulusSion.gaux"
OUTCOME=$(grep -E 'PopulusSion\.(gabc|gaux)' PopulusSion.fls | sort -u)

echo "EXPECTED: $EXPECTED"
echo "OUTCOME: $OUTCOME"

[[ "$OUTCOME" == "$EXPECTED" ]] || exit 1

lualatex --shell-escape --interaction=nonstopmode --recorder PopulusSion
EXPECTED="INPUT PopulusSion.gaux"
OUTCOME=$(grep -E 'PopulusSion\.(gabc|gaux)' PopulusSion.fls | sort -u)

echo "EXPECTED: $EXPECTED"
echo "OUTCOME: $OUTCOME"

[[ "$OUTCOME" == "$EXPECTED" ]] || exit 1

