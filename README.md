# docker-cron

## How to Use

1. Create a folder to store executable files which will launch by crond.

2. Create **executable** files with specified prefix filename.

   | Period | Prefix | Example |
   | ------ | ------ | ------- |
   | 1 minute | 1m\_ or 1min\_ | 1m\_hello.sh |
   | 5 minutes | 5m\_ or 5min\_ | 5min\_hello.sh |
   | 10 minutes | 10m\_ or 10min\_ | 10m\_hello.sh |
   | 15 minutes | 15m\_ or 15min\_ | 15min\_hello.sh |
   | 30 minutes | 30m\_ or 30min\_ | 30m\_hello.sh |
   | 1 hour | 1h\_ or 1hour\_ | 1h\_hello.py |
   | 12 hours | 12h\_ or 12hour\_ | 12hour\_hello.py |
   | 1 day | 1d\_ or 1day\_ | 1d\_hello.py |
   | 1 week | 1w\_ or 1week\_ | 1week\_hello.py |
   | 1 month | 1M\_ or 1month\_ | 1M\_hello.py |

3. Replace _/path/to/folder_ in the following command, and run it.


```sh
docker run -d --name cron -v /path/to/folder:/usr/local/cron minimum/cron:py3
```
