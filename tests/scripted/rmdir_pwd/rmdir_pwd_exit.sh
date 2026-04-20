case "$(uname -s)" in
    CYGWIN*|MINGW*|MSYS*)
        echo "Skipping rmdir_pwd_exit.sh: Windows does not allow removing the current working directory"
        exit 4
        ;;
esac

mkdir temp
cd temp
rmdir ../temp
eval $gregorio nonexistent.gabc
[[ $? == "1" ]] || exit 1
