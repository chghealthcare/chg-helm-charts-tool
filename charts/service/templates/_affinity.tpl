{{- define "service.affinity" }}
{{- if or ( .Values.persistentVolume ) ( .Values.postgres) }}
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: px/enabled
          operator: In
          values:
          - "true"
      - matchExpressions:
        - key: NodeType
          operator: In
          values:
          - "storage"

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
        - key: px/enabled
          operator: In
          values:
          - "false"
      - matchExpressions:
        - key: NodeType
          operator: In
          values:
          - "general-purpose"
{{- end }}
{{- end }}