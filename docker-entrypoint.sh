#!/bin/bash

set -e

# support python3 pip install
if [[ ! -z "$(which pip3)" ]]
then
    find $WORKSPACE -type f -name requirements.txt -exec pip3 install -U -r {} pip \;
fi

# support python2 pip install
if [[ ! -z "$(which pip2)" ]]
then
    find $WORKSPACE -type f -name requirements.txt -exec pip2 install -U -r {} pip \;
fi

# separate executable files
if [[ (-z "$1" || "$1" == '-f') && ! -z "$CRON" && ! -z "$PERIOD" ]]
then
    for file in $(find $WORKSPACE -type f -perm +100)
    do
        fullname=$(basename $file)
        name=${fullname%.*}
        flag=$(awk -v var=$name 'BEGIN{ split(var, flag, "_"); print flag[1]}')
        link=${name#${flag}_}

        case $flag in
        '1m'|'1min')
            ln -s $file $PERIOD/1min/$link
            ;;
        '5m'|'5min')
            ln -s $file $PERIOD/5min/$link
            ;;
        '10m'|'10min')
            ln -s $file $PERIOD/10min/$link
            ;;
        '15m'|'15min')
            ln -s $file $PERIOD/15min/$link
            ;;
        '30m'|'30min')
            ln -s $file $PERIOD/30min/$link
            ;;
        '1h'|'1hour')
            ln -s $file $PERIOD/1hour/$link
            ;;
        '12h'|'12hour')
            ln -s $file $PERIOD/12hour/$link
            ;;
        '1d'|'1day')
            ln -s $file $PERIOD/1day/$link
            ;;
        '1w'|'1week')
            ln -s $file $PERIOD/1week/$link
            ;;
        '1M'|'1month')
            ln -s $file $PERIOD/1month/$link
            ;;
        *)
            echo "No support $fullname"
            ;;
        esac
    done

    if [[ "$1" == '-f' ]]
    then
        find -L $PERIOD -type f -perm +100 -exec {} \;
    fi

    echo "start crond"
    exec crond -f -c $CRON
fi

exec "$@"
