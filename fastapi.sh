#!/bin/bash
HOME=/webapps/clkec/production
NAME="fastapi"
VENVDIR=/webapps/clkec/production/project/.venv
DJANGODIR=$HOME/project/
SOCKFILE=/webapps/clkec/production/socks/gunicorn.sock
USER=clkec
GROUP=webapps
NUM_WORKERS=1
DJANGO_SETTINGS_MODULE=PROJECTNAME.settings
ACCESS_LOGFILE=/webapps/clkec/production/logs/fastapi_access.log
ERROR_LOGFILE=/webapps/clkec/production/logs/fastapi_error.log
LOGFILE=/webapps/clkec/production/logs/fastapi.log
LOGLEVEL=info


# Activate the virtual environment
cd $DJANGODIR
source $VENVDIR/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$VENVDIR:$DJANGODIR:$PYTHONPATH


exec uvicorn  --workers 3 --host 127.0.0.1 --port 8002


#!/bin/bash
HOME=/webapps/clkec/production
NAME="fastapi"
VENVDIR=/webapps/clkec/production/project/.venv
DJANGODIR=$HOME/project/
USER=clkec
GROUP=webapps
NUM_WORKERS=1
ACCESS_LOGFILE=/webapps/clkec/production/logs/fastapi_access.log
ERROR_LOGFILE=/webapps/clkec/production/logs/fastapi_error.log
LOGFILE=/webapps/clkec/production/logs/fastapi.log
LOGLEVEL=info
BIND=127.0.0.1:8002

# Activate the virtual environment
cd $DJANGODIR
source $VENVDIR/bin/activate
#export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$VENVDIR:$DJANGODIR:$PYTHONPATH


exec gunicorn -k uvicorn.workers.UvicornWorker PROJECTNAME.asgi:app \
  --name $NAME \
  --workers 3 \
  --user=$USER \
  --group=$GROUP \
  --bind=$BIND \
  --timeout=90 \
  --graceful-timeout=10 \
  --log-level=$LOGLEVEL \
  --error-logfile=$ERROR_LOGFILE \
  --log-file=$LOGFILE \
  --access-logfile=$ACCESS_LOGFILE

