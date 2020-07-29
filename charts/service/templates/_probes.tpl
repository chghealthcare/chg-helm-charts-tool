
{{- define "service.probes" }}
livenessProbe:
  httpGet:
  {{- if .Values.health.liveness.path }}
    path: {{ .Values.health.liveness.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.liveness.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.liveness.periodSeconds }}
  {{- else }}
    path: {{ .Values.health.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.periodSeconds }}
  {{- end }}
readinessProbe:
  httpGet:
  {{- if .Values.health.readiness.path }}
    path: {{ .Values.health.readiness.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.readiness.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.readiness.periodSeconds }}
  {{- else }}
    path: {{ .Values.health.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.periodSeconds }}
  {{- end }}
{{- end }}
