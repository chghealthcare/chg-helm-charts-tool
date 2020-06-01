{{- define "service.affinity" }}
{{- if .Values.persistentVolume }}
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: px/enabled
          operator: NotIn
          values:
          - "false"
        - key: worker-type
          operator: NotIn
          values:
          - jenkins-workers
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