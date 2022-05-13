#!/bin/bash
HOME=/webapps/clkec/production
NAME="website"
VENVDIR=/webapps/clkec/production/project/.venv
DJANGODIR=$HOME/project/
USER=clkec
GROUP=webapps
NUM_WORKERS=1
DJANGO_SETTINGS_MODULE=PROJECTNAME.settings
DJANGO_WSGI_MODULE=PROJECTNAME.wsgi
ACCESS_LOGFILE=/webapps/clkec/production/logs/website_access.log
ERROR_LOGFILE=/webapps/clkec/production/logs/website_error.log
LOGFILE=/webapps/clkec/production/logs/website.log
LOGLEVEL=info

echo "Starting $NAME as `whoami`"

# Activate the virtual environment
cd $DJANGODIR
source $VENVDIR/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$VENVDIR:$DJANGODIR:$PYTHONPATH

BIND="127.0.0.1:8001"

# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)
exec gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user=$USER --group=$GROUP \
  --bind=$BIND \
  --timeout=90 \
  --graceful-timeout=10 # --log-level=$LOGLEVEL --error-logfile=$ERROR_LOGFILE --log-file=$LOGFILE --access-logfile=$ACCESS_LOGFILE
