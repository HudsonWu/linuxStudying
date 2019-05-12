# view

```
# Get Services IPs range
kubectl cluster-info dump | grep -m 1 service-cluster-ip-range

# Get Pods IPs range
kubectl cluster-info dump | grep -m 1 cluster-cidr
```

