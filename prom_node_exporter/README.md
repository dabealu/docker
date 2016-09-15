####Prometheus monitoring system https://prometheus.io
Prometheus containerized node-exporter with nginx ssl (certs dir) and basic auth (htpasswd)
Both containers uses host network, node-exporter on 127.0.0.1:9199 and nginx on *:9100 (default node exporter port)
