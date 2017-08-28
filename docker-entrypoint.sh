#!/bin/bash

set -e

# support python3 pip install
if [ ! -z "$(which pip3)" ]
then
    find $WORKSPACE -type f -name requirements.txt -exec pip3 install -U -r {} pip \;
fi

# support python2 pip install
if [ ! -z "$(which pip2)" ]
then
    find $WORKSPACE -type f -name requirements.txt -exec pip2 install -U -r {} pip \;
fi

# separate executable files
if [ -z "$1" ] && [ ! -z "$CRON" ] && [ ! -z "$PERIOD" ]
then
    for file in $(find $WORKSPACE -type f -perm +100)
    do
        name=$(basename $file)
        token=($(awk -v var=$name 'BEGIN{ split(var, flag, "_"); split(flag[2], file, "."); print flag[1], file[1]}'))
        
        case ${token[0]} in
        '1m'|'1min')
            ln -s $file $PERIOD/1min/${token[1]}
            ;;
        '5m'|'5min')
            ln -s $file $PERIOD/5min/${token[1]}
            ;;
        '10m'|'10min')
            ln -s $file $PERIOD/10min/${token[1]}
            ;;
        '15m'|'15min')
            ln -s $file $PERIOD/15min/${token[1]}
            ;;
        '30m'|'30min')
            ln -s $file $PERIOD/30min/${token[1]}
            ;;
        '1h'|'1hour')
            ln -s $file $PERIOD/1hour/${token[1]}
            ;;
        '12h'|'12hour')
            ln -s $file $PERIOD/12hour/${token[1]}
            ;;
        '1d'|'1day')
            ln -s $file $PERIOD/1day/${token[1]}
            ;;
        '1w'|'1week')
            ln -s $file $PERIOD/1week/${token[1]}
            ;;
        '1M'|'1month')
            ln -s $file $PERIOD/1month/${token[1]}
            ;;
        *)
            echo "No support ${token[0]}"
            ;;
        esac
    done

    exec crond -f -c $CRON
fi

exec "$@"
