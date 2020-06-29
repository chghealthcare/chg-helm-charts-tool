{{- define "service.affinity" }}
{{- if or .Values.persistentVolume .Values.persistentVolumeClaim }}
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: px/enabled
          operator: NotIn
          values:
          - "false"
{{- else if (eq .Values.environment "stage") }}
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: dedicated
          operator: In
          values:
          - "stage"
{{- else if .Values.affinity -}}
{{- with .Values.affinity }}
affinity:
{{ toYaml . | indent 2 }}
{{- end }}
{{- else }}
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: worker-type
            operator: NotIn
            values:
            - jenkins-workers
{{- end }}
{{- end }}