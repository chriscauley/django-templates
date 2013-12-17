if [ -n $1]; then
    T="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/project"
    echo "yay"
    #django-admin.py startproject $1 --template=$T --extension=sh --extension=conf $2
    exit 0
fi
else 
