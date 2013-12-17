if [ -n "$1" ]; then
    T="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/project"
    django-admin.py startproject $1 --template=$T --extension=sh --extension=conf $2
    echo "Project $1 created"
    exit 0
fi
echo "USAGE: startproject.sh <project_name> [destination]"
