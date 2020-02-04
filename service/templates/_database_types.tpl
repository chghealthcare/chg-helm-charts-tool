{{- define "service.database.neo4j" }}
- name: {{ .Chart.Name }}-neo4j
  image: "977624198390.dkr.ecr.us-west-2.amazonaws.com/neo4j:latest"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  env:
    {{- range .Values.envs }}
    - name: {{ .name | quote }}
      value: {{ .value | quote }}
    {{- end }}
  envFrom:
    {{- range .Values.secretRefs }}
    - secretRef:
        name: {{ . | quote}}
    {{- end }}
  ports:
  - name: http
  containerPort: {{ .Values.service.target }}
  protocol: TCP
{{- end }}