{{- if .Values.config.files }}
{{ $ctx := . }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "microfleet.fullname" . }}-config
  labels:
    app: {{ .Release.Name }}
    release: {{ .Release.Name }}
    version: {{ .Values.image.tag | quote }}
data:
{{- range $filename, $content := .Values.config.files }}
  {{ $filename }}: |
    {{ tpl $content $ctx | indent 4 | trim }}
{{- end }}
{{- end }}

