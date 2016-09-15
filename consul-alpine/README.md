consul runs under consul user (id=1000, gid=1000) in container, so set correct permissions for 'consul_data' and 'consul_config' dirs.


full:
{
  "Datacenter": "dc1",
  "Node": "foobar",
  "Address": "192.168.10.10",
  "Service": {
    "ID": "redis1",
    "Service": "redis",
    "Tags": [
      "master",
      "v1"
    ],
    "Address": "127.0.0.1",
    "TaggedAddresses": {
      "wan": "127.0.0.1"
    },
    "Port": 8000
  },
  "Check": {
    "Node": "foobar",
    "CheckID": "service:redis1",
    "Name": "Redis health check",
    "Notes": "Script based health check",
    "Status": "passing",
    "ServiceID": "redis1"
  }
}


curl -XPUT -d @- localhost:8500/v1/catalog/register <<EOF
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

simple:
curl -XPUT -d @- localhost:8500/v1/catalog/register <<EOF
{
  "Node": "node3",
  "Address": "10.0.0.3",
  "Service": {
    "Service": "service1"
  }
}
EOF


