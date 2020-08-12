
{{- define "service.probes" }}
livenessProbe:
  httpGet:
    path: {{ .Values.health.liveness.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.liveness.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.liveness.periodSeconds }}
  failureThreshold: {{ .Values.health.liveness.failureThreshold }}
readinessProbe:
  httpGet:
    path: {{ .Values.health.readiness.path | quote }}
    port: {{ .Values.service.target }}
  initialDelaySeconds: {{ .Values.health.readiness.initialDelaySeconds }}
  periodSeconds: {{ .Values.health.readiness.periodSeconds }}
  failureThreshold: {{ .Values.health.readiness.failureThreshold }}
{{- end }}
