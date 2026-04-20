# Verify that gregorio does not crash (segfault) when processing a GABC file
# with consecutive NABC separators (||) that cause the NABC state to wrap.
# See https://github.com/gregorio-project/gregorio/issues/1726

"$gregorio_path" -f gabc -F gtex test.gabc > /dev/null 2>&1
exit_code=$?

# A signal-killed process has exit code 128+signal (e.g. 139 for SIGSEGV).
# Any exit code >= 128 indicates the process was killed by a signal.
if [[ $exit_code -ge 128 ]]; then
    exit 1
fi
