# Verify that GregorioTeX's post_linebreak() does not crash with
# "attempt to index a nil value (local 'lastglyph')" when a natural TeX
# line break falls on a mid-word syllable whose GABC <v>...</v> text
# wraps a nested box (e.g. \hbox{...}), instead of top-level glyphs.
# See https://github.com/gregorio-project/gregorio/issues/1762

rm -f score.gtex score.glog document.aux document.log document.pdf

"$gregorio_path" -f gabc -F gtex score.gabc >/dev/null 2>&1 || exit 1

lualatex --interaction=nonstopmode --halt-on-error document >/dev/null 2>&1
exit_code=$?

if [[ $exit_code -ne 0 ]]; then
    exit 1
fi

[[ -f document.pdf ]] || exit 1
