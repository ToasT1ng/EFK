# EFK
This project uses docker & docker-compose. Before you begin, you should install them first.

## Kibana

## Elasticsearch
Single node.

###How to use?
Simply run elasticsearch.sh
```
~$ bash elasticsearch.sh
```

## Fluentd-Aggregator

## Fluentd
You can use this with some log files. **Fluentd** will read logs in json format from your service's log files and send them to **Fluentd-Aggregator**. 

### How to use?
Simply run `fluentd.sh`
```
~$ bash fluentd.sh --log <YOUR_LOG_PATH>
```
<br/>

Do you want to know how to use `fluentd.sh`? Just type like this.
```
~$ bash fluentd.sh --help
```

<br/>

## Run all together
If you want to run all together, simply run `run-all-together.sh`
```
~$ bash run-all-together.sh --log <YOUR_LOG_PATH>
```
It will be executed with docker-compose.

<br/>

## See Also
This project is related to [Simple-Logging-API](https://github.com/ToasT1ng/Simple-Logging-API)