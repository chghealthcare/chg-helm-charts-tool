# Neo4j Databases - Neo4j-graphileon is the default DB, and Neo4j is specific to EDM, this naming should be updated to reflect more accuratlety.
{{- define "service.database" }}
{{- if eq .Values.databasetype "neo4j" }}
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
    containerPort: 7687
    protocol: TCP
{{- end }}
{{- if eq .Values.databasetype "neo4j-graphileon" }}
- name: {{ .Chart.Name }}-neo4j
  image: "977624198390.dkr.ecr.us-west-2.amazonaws.com/neo4j-graphileon:latest"
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
    containerPort: 7687
    protocol: TCP
{{- end }}
{{- if eq .Values.databasetype "postgres" }}
- name: {{ .Chart.Name }}-postgres
  image: {{ .Values.databaseimage | default "postgres:11.2-alpine" | quote}}
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
  - name: postgres
    containerPort: 5432
    protocol: TCP
{{- end }}
{{- end }}
