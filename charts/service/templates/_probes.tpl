
{{- define "service.probes" }}
livenessProbe:
  httpGet:
    path: {{ .Values.health.liveness.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.liveness.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.liveness.periodSeconds }}
readinessProbe:
  httpGet:
    path: {{ .Values.health.readiness.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.readiness.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.readiness.periodSeconds }}
{{- end }}
