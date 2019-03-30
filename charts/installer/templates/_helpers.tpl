{{- define "microfleet.fullname" -}}
{{- default .Release.Name .Values.name -}}
{{- end -}}

{{- define "microfleet.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "health" -}}
{{- if or .exec (or .httpGet .tcpSocket) -}}true{{- end -}}
{{- end -}}
