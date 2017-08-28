# docker-cron

## How to Use

1. Create a folder to store executable files which will launch by crond

2. Replace _/path/to/folder_ in the following command, and run it.


```sh
docker run -d --name cron -v /path/to/folder:/usr/local/cron minimum/cron:py3
```
