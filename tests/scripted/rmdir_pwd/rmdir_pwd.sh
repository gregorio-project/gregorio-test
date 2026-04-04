case "$(uname -s)" in
    CYGWIN*|MINGW*|MSYS*)
        echo "Skipping rmdir_pwd.sh: Windows does not allow removing the current working directory"
        exit 4
        ;;
esac

mkdir temp
cd temp
rmdir ../temp
EXPECTED="error: can't determine current directory"
echo "$EXPECTED"

echo ==========
OUTCOME=$("$gregorio_path" nonexistent.gabc 2>&1 1> /dev/null | tr -d '\r')
echo ==========
echo "$OUTCOME"

[[ "$EXPECTED" == "$OUTCOME" ]] || exit 1
