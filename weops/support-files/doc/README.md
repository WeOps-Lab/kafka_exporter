## 嘉为蓝鲸Kafka插件使用说明

## 使用说明

### 插件功能
连接到Kafka，获取与主题、消费者组以及其他相关数据。帮助用户监控Kafka健康状态、性能指标以及消费者行为。

### 版本支持

操作系统支持: linux, windows

是否支持arm: 支持

**组件支持版本：**

kafka版本: >= 0.10.1.0
部署模式支持: 单机(Standalone), 集群(Cluster)

**是否支持远程采集:**

是

### 参数说明


| **参数名**              | **含义**                                                             | **是否必填** | **使用举例**       |
|----------------------|--------------------------------------------------------------------|----------|----------------|
| --kafka.server       | kafka服务主机ip:服务端口，若为集群，也请填写单个ip和服务端口                                | 是        | 127.0.0.1:9092 |
| --kafka.version      | kafka服务版本                                                          | 是        | 0.10.1.0       |
| --sasl.enabled       | SASL认证开关(开关参数)                                                     | 是        |                |
| SASL_USERNAME        | kafka SASL用户名(环境变量)                                                | 是        | weops          |
| SASL_PASSWORD        | kafka SASL用户的密码(环境变量)                                              | 是        | weops123       |
| SASL_MECHANISM       | kafka SASL机制(环境变量)，若不开启SASL则填空，否则可填plain、scram-sha512、scram-sha256 | 否        | plain          |
| TOPIC_FILTER         | 筛选并留下含有正则关键字的主题(环境变量)，默认不过滤                                        | 是        | .*             |
| TOPIC_EXCLUDE        | 筛选并排除含有正则关键字的主题(环境变量)，默认不过滤                                        | 是        | ^$             |
| GROUP_FILTER         | 筛选并留下含有正则关键字的消费者组(环境变量)，默认不过滤                                      | 是        | .*             |
| GROUP_EXCLUDE        | 筛选并排除含有正则关键字的消费者组(环境变量)，默认不过滤                                      | 是        | ^$             |
| --verbosity          | 日志级别，默认为0，0(ERROR级别)，1(INFO级别)，(DEBUG级别)                           | 否        | 0              |
| --web.listen-address | exporter监听id及端口地址                                                  | 否        | 127.0.0.1:9601 |



### 使用指引
1. 查看kafka版本
   有以下几种方式:
   - 进入kafka安装目录，比如`/opt/kafka_2.11-0.11.0.3/bin`，那么该kafka版本为`0.11.0.3`
   - 进入kafka目录，比如`/opt/kafka/libs`，该路径底下的包会含有版本信息，比如` kafka_2.12-0.10.2.0.jar`，那么该kafka版本为`0.10.2.0`

2. 主题和消费者组过滤选项
   支持主题和消费者组的过滤，需要注意如果主题过多或者在集群的模式下，可能监控获取到的数据量会较大，指标抓取时长会增加并且会占用较多的cpu资源， 
   一般建议缩小监控的主题和消费者组范围，减少指标抓取时长和资源占用。若需要全部数据，注意要增加抓取时长等待时间(采集任务采集周期)。

### 指标简介


| **指标ID**                                         | **指标中文名**               | **维度ID**                        | **维度含义**           | **单位** |
|--------------------------------------------------|-------------------------|---------------------------------|--------------------|--------|
| kafka_up                                         | Kafka监控探针运行状态           | -                               | -                  | -      |
| kafka_brokers                                    | Kafka集群中的 Broker 数量     | -                               | -                  | -      |
| kafka_broker_info                                | Kafka节点信息               | address, id                     | 节点地址, 节点ID         | -      |
| kafka_topic_partitions                           | Kafka主题的分区数量            | topic                           | 主题名称               | -      |
| kafka_topic_partition_current_offset             | Kafka主题分区的当前偏移量         | partition, topic                | 分区ID, 主题名称         | -      |
| kafka_topic_partition_oldest_offset              | Kafka主题分区的最早偏移量         | partition, topic                | 分区ID, 主题名称         | -      |
| kafka_topic_partition_in_sync_replica            | Kafka主题分区的同步副本数量        | partition, topic                | 分区ID, 主题名称         | -      |
| kafka_topic_partition_leader                     | Kafka主题分区的领导者节点ID       | partition, topic                | 分区ID, 主题名称         | -      |
| kafka_topic_partition_leader_is_preferred        | Kafka主题分区首选节点使用状态       | partition, topic                | 分区ID, 主题名称         | -      |
| kafka_topic_partition_replicas                   | Kafka主题分区的副本数量          | partition, topic                | 分区ID, 主题名称         | -      |
| kafka_topic_partition_under_replicated_partition | Kafka主题分区副本不足状态         | partition, topic                | 分区ID, 主题名称         | -      |
| kafka_consumergroup_current_offset               | Kafka消费者组在主题分区的当前偏移量    | consumergroup, partition, topic | 消费者组名称, 分区ID, 主题名称 | -      |
| kafka_consumergroup_lag                          | Kafka消费者组在主题分区的当前滞后的偏移量 | consumergroup, partition, topic | 消费者组名称, 分区ID, 主题名称 | -      |
| process_cpu_seconds_total                        | Kafka监控探针进程CPU秒数总计      | -                               | -                  | s      |
| process_max_fds                                  | Kafka监控探针进程最大文件描述符数     | -                               | -                  | -      |
| process_open_fds                                 | Kafka监控探针进程打开文件描述符数     | -                               | -                  | -      |
| process_resident_memory_bytes                    | Kafka监控探针进程常驻内存大小       | -                               | -                  | bytes  |
| process_virtual_memory_bytes                     | Kafka监控探针进程虚拟内存大小       | -                               | -                  | bytes  |


### 版本日志

#### weops_kafka_exporter 2.8.1

- weops调整


添加“小嘉”微信即可获取kafka监控指标最佳实践礼包，其他更多问题欢迎咨询

<img src="https://wedoc.canway.net/imgs/img/小嘉.jpg" width="50%" height="50%">