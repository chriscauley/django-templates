#! /bin/bash
USER="deploy"
GROUP="deploy"
WORKERS=1
PORT=8009

APP_ROOT="/var/www/apps/{{ project_name }}/site"
SHARED_ROOT="/var/www/apps/{{ project_name }}/shared"
PID="$SHARED_ROOT/pid/gunicorn.pid"
OLDPID="$SHARED_ROOT/pid/gunicorn.pid.oldbin"
LOGFILE="$SHARED_ROOT/log/gunicorn-{{ project_name }}.log"
EXE="$APP_ROOT/env/bin/gunicorn_django"
SOCKET=unix:$SHARED_ROOT/sockets/gunicorn-{{ project_name }}.socket
DAEMON_CMD="$EXE -D -p $PID -b $SOCKET -w $WORKERS --user=$USER --group=$GROUP --log-level=debug --log-file=$LOGFILE 2>>$LOGFILE"
FULL_CMD="cd $APP_ROOT/; source $APP_ROOT/env/bin/activate;$DAEMON_CMD;"
NAME="gunicorn-{{ project_name }}"
DESC="{{ project_name }} site service"
PATH=$PATH:/usr/local/bin

case "$1" in
  start)
        cd $APP_ROOT
        source "$APP_ROOT/env/bin/activate"

        echo -n "Starting $DESC: "
        if [ `whoami` = root ]; then
          sudo -u $USER -H bash -l -c "$FULL_CMD"
        else
          bash -c "$FULL_CMD"
        fi
        echo "$NAME."
        ;;
  stop)
        echo -n "Stopping $DESC: "
        if [ -e $PID ]; then
            kill -QUIT `cat $PID`
        fi
        if [ -e $OLDPID ]; then
            kill -QUIT `cat $OLDPID`
        fi
        echo "$NAME."
        ;;
  restart)
        echo -n "Restarting $DESC: "
        if [ -e $PID ]; then
            kill -USR2 `cat $PID`
        fi
        if [ -e $OLDPID ]; then
            kill -USR2 `cat $OLDPID`
        fi
        echo "$NAME."
        ;;
  reload)
        echo -n "Reloading $DESC configuration: "
        if [ -e $PID ]; then
            kill -HUP `cat $PID`
        fi
        if [ -e $OLDPID ]; then
            kill -HUP `cat $OLDPID`
        fi
        echo "$NAME."
        ;;
  *)
        echo "Usage: $NAME {start|stop|restart|reload}" >&2
        exit 1
        ;;
esac

exit 0
