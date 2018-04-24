if [ -n "$1" ]; then
    T="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/project"
    django-admin.py startproject $1 --template=$T --extension=sh --extension=conf $2
    ln -s /home/chriscauley/.dev/ $1
    ln -s /home/chriscauley/node_modules/ $1
    cd $1
    echo "VENV time"
    virtualenv .e
    source .e/bin/activate
    echo "requirements..."
    pip install -r requirements.txt
    #python manage.py migrate
    echo "Project $1 created"
    exit 0
fi
echo "USAGE: startproject.sh <project_name> [destination]"
