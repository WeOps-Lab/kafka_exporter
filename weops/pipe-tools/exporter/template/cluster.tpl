apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: kafka-exporter-{{VERSION}}
  namespace: kafka
spec:
  serviceName: kafka-exporter-{{VERSION}}
  replicas: 1
  selector:
    matchLabels:
      app: kafka-exporter-{{VERSION}}
  template:
    metadata:
      annotations:
        telegraf.influxdata.com/interval: 1s
        telegraf.influxdata.com/inputs: |+
          [[inputs.cpu]]
            percpu = false
            totalcpu = true
            collect_cpu_time = true
            report_active = true

          [[inputs.disk]]
            ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]

          [[inputs.diskio]]

          [[inputs.kernel]]

          [[inputs.mem]]

          [[inputs.processes]]

          [[inputs.system]]
            fielddrop = ["uptime_format"]

          [[inputs.net]]
            ignore_protocol_stats = true

          [[inputs.procstat]]
          ## pattern as argument for exporter (ie, exporter -f <pattern>)
            pattern = "exporter"
        telegraf.influxdata.com/class: opentsdb
        telegraf.influxdata.com/env-fieldref-NAMESPACE: metadata.namespace
        telegraf.influxdata.com/limits-cpu: '300m'
        telegraf.influxdata.com/limits-memory: '300Mi'
      labels:
        app: kafka-exporter-{{VERSION}}
        exporter_object: kafka
        object_mode: cluster
        object_version: {{VERSION}}
        pod_type: exporter
    spec:
      nodeSelector:
        node-role: worker
      shareProcessNamespace: true
      containers:
      - name: kafka-exporter-{{VERSION}}
        image: registry-svc:25000/library/kafka-exporter:latest
        imagePullPolicy: Always
        securityContext:
          allowPrivilegeEscalation: false
          runAsUser: 0
        args:
          - --kafka.server=kafka-cluster-v3-5-controller-headless.kafka:9094
          - --kafka.version={{STRING_VERSION}}
          - --sasl.enabled
        env:
        - name: SASL_USERNAME
          value: weops
        - name: SASL_PASSWORD
          value: Weops@#!$123
        - name: SASL_MECHANISM
          value: plain
        - name: TOPIC_FILTER
          value: .*consumer_offsets.*
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
          limits:
            cpu: 500m
            memory: 500Mi
        ports:
        - containerPort: 9308

---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: kafka-exporter-{{VERSION}}
  name: kafka-exporter-{{VERSION}}
  namespace: kafka
  annotations:
    prometheus.io/scrape: "true"
    prometheus.io/port: "9308"
    prometheus.io/path: '/metrics'
spec:
  ports:
  - port: 9308
    protocol: TCP
    targetPort: 9308
  selector:
    app: kafka-exporter-{{VERSION}}
