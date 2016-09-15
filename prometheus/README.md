####Prometheus monitoring system https://prometheus.io

Prom in containers:
https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-using-docker-on-centos-7

Uses pull mechanism (and can use push with pushgateway).
Server pulls (scrapes in prometheus terms) metrics periodically from client that exposes /metrics http location, e.g.:
http://serverip:9100/metrics

In Prometheus terms, any individually scraped target is called an instance, usually corresponding to a single process. A collection of instances of the same type (replicated for scalability or reliability) is called a job.
When Prometheus scrapes a target, it attaches some labels automatically to the scraped time series which serve to identify the scraped target:
    job: The configured job name that the target belongs to.
    instance: The <host>:<port> part of the target's URL that was scraped.

Each metric has name and optionally set of labels (key-values):
metric_name{label="test",instance="example.com:9100",job="prometheus"}


Grafana:
 - data source: type: prometheus, default: yes, url: http://prometheus:9090
 - dynamic labels example: for metric node_memory_MemTotal{instance="192.168.1.100:9100",job="node"} in legend format use {{instance}} or {{job}} to refer on its value.

Retention:
How long to retain samples in the local storage.
   -storage.local.retention 360h0m0s
If you have set a very long retention time via the storage.local.retention flag (more than a month), you might want to increase the flag value storage.local.series-file-shrink-ratio.

Reload prometheus config through http: curl -X POST http://localhost:9090/-/reload

Query language examples:
https://prometheus.io/docs/querying/examples/

More query examples:
  show average cpu (all cores) idle per instance (metrics from node-exporter)
avg(node_cpu{mode="idle",cpu=~"cpu.*"}) by (instance)
  CPU usage (http://www.robustperception.io/understanding-machine-cpu-usage/)
100 - (avg by (instance) (irate(node_cpu{job="node",mode="idle"}[5m])) * 100)
  used memory (100% - available_memory%), available=free+cache
100 - (node_memory_MemAvailable/node_memory_MemTotal)*100
  summary cpu usage% by containers (metrics exported by cadvisor)
sum(irate(container_cpu_usage_seconds_total{id=~"/docker/.*"}[15m])) by (name) *100

For HTTP(S), ICMP, DNS etc checks you can use blackbox-exporter (https://hub.docker.com/r/prom/blackbox-exporter/)
blackbox metrics start with 'probe_' prefix
to split metric types use different config blocks(job_name) with different 'module' value, eg:
  - job_name: 'blackbox-icmp'
    params:
      module: [icmp]
    ...
  - job_name: 'blackbox'
    params:
      module: [http_2xx] 
    ...

To reload prometheus configuration (DOESNT WORK FOR CONTAINERIZED PROMETHEUS, RESTART CONTAINER :/ ):
curl -k -u user:password -X POST http://localhost:9090/-/reload
To check config or rules use promtool, eg:
docker-compose exec prometheus promtool check-config /etc/prometheus/prometheus.yml



Consul
Consul runs under consul user (id=1000, gid=1000) in container, so set correct permissions for 'consul_data' and 'consul_config' dirs:
  chown -R 1000:1000 consul_*
  chmod -R 775 consul_*
Example to create new service (you can drop or add some fields, see consul docs):
curl -XPUT -u prom:855482fef2b0 -k -d @- https://localhost:8500/v1/catalog/register <<EOF
{
  "Datacenter": "dc1",
  "Node": "node1",
  "Address": "10.0.0.1",
  "Service": {
    "ID": "id1",
    "Service": "service1",
    "Tags": [
      "tag1",
      "tag2"
    ],
    "Address": "127.0.0.1",
    "Port": 80
  }
}
EOF
get nodes:
curl -u prom:855482fef2b0 -k https://localhost:8500/v1/catalog/nodes | jq .
curl -u prom:855482fef2b0 -k https://localhost:8500/v1/catalog/node/node_name | jq .
get services:
curl -u prom:855482fef2b0 -k https://localhost:8500/v1/catalog/services | jq .
curl -u prom:855482fef2b0 -k https://localhost:8500/v1/catalog/service/service_name | jq .
