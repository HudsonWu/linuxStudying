# Grafana

## 安装和配置 

+ 安装文档: <http://docs.grafana.org/installation/rpm>

+ 开启命令: `systemctl start grafana-server.service`

### 配置

配置文件: /etc/grafana/grafana.ini

1. 编辑grafana.ini文件
```
[dashboards.json]
enabled = true
path = /var/lib/grafana/dashboards
```

2. 安装仪表盘
```
// mysql图表模板(Percona提供的模板)
git clone https://github.com/percona/grafana-dashboards.git
// 复制所有模板到指定位置
cp -r grafana-dashboards/dashborads /var/lib/grafana/


node_exporter: 
5573  "Host Stats - Prometheus Node Exporter"

redis_exporter: 
763  "Prometheus Redis"
2751  "Prometheus Redis"

nginx-vts_exporter:
2949  "Nginx VTS Stats"
```
