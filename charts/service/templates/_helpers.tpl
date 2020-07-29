{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "service.environment" -}}
{{- default .Values.environment .Values.NODE_ENV -}}
{{- end -}}
{{- define "service.environmentShort" -}}
{{- if contains "feature" .Release.Namespace -}}
{{- printf "%s" "dev" -}}
{{- else -}}
{{- printf "%s" .Release.Namespace -}}
{{- end -}}
{{- end -}}
{{- define "service.istiogateway" -}}
{{ pluck .Values.environment .Values.istiogateway | first | default .Values.istiogateway._default }}
{{- end -}}
{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "service.fullname" -}}
{{- printf "%s-%s" .Values.feature .Values.project | trunc 63 | trimPrefix "-" | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "service.commonLabels" -}}
app.kubernetes.io/name: {{ default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
