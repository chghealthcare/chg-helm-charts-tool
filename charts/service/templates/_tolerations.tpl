{{- define "service.tolerations" }}
{{- if .Values.persistentVolume }}
tolerations:
- key: "dedicated"
  operator: "Equal"
  value: "storage"
  effect: "NoSchedule"

{{- else if .Values.tolerations -}}
{{- with .Values.tolerations }}
tolerations:
{{ toYaml . | indent 2 }}
{{- end }}
{{- end }}
{{- end }}