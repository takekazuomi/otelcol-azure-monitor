# OpenTelemetry Collector Builder (ocb)

https://github.com/open-telemetry/opentelemetry-collector/tree/main/cmd/builder

OpenTelemetry Collector Builder (ocb) を使って、Azure Monitor 用の OpenTelemetry Collector Image を作成する。

otelcol-builder.yaml

```yml
dist:
  name: otelcol-azure-monitor
  description: Azure Monitor OpenTelemetry Collector binary
  output_path: ./gen
exporters:
  - gomod: github.com/open-telemetry/opentelemetry-collector-contrib/exporter/azuremonitorexporter v0.85.0
  - gomod: go.opentelemetry.io/collector/exporter/loggingexporter v0.85.0

receivers:
  - gomod: go.opentelemetry.io/collector/receiver/otlpreceiver v0.85.0

processors:
  - gomod: go.opentelemetry.io/collector/processor/batchprocessor v0.85.0

extensions:
  - gomod: github.com/open-telemetry/opentelemetry-collector-contrib/extension/healthcheckextension v0.85.0
```

## Ref

- [Azure Monitor Exporter](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/exporter/azuremonitorexporter/README.md)

