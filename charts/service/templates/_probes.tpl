
{{- define "service.probes" }}
livenessProbe:
  httpGet:
  {{- if .Values.health.path }}
    path: {{ .Values.health.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.periodSeconds }}
  {{- else }}
    path: {{ .Values.health.liveness.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.liveness.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.liveness.periodSeconds }}
  {{- end }}
readinessProbe:
  httpGet:
  {{- if .Values.health.path }}
    path: {{ .Values.health.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.periodSeconds }}
  {{- else }}
    path: {{ .Values.health.readiness.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.readiness.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.readiness.periodSeconds }}
  {{- end }}
{{- end }}
