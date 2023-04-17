{{/*
Expand the name of the chart.
*/}}
{{- define "app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "app.labels" -}}
helm.sh/chart: {{ include "app.chart" . }}
app.kubernetes.io/name: {{ include "app.name" . }}
{{ include "app.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: "{{ .Chart.Name }}"
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "app.selectorLabels" -}}
app: {{ include "app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* 
Service account name
*/}}
{{- define "app.serviceAccountName" -}}
{{- printf "app-db-mysql-demand360-secrets-pull-service-account" -}}
{{- end -}}

{{/* 
Secret Provider Class name
*/}}
{{- define "app.secretProviderClassName" -}}
{{- printf "app-%s-sercrets-credentials" .Chart.Name -}}
{{- end -}}

{{/* 
Secret name
*/}}
{{- define "app.dbsecrets.secretName" -}}
{{- printf "app-%s-db-secret-name" .Chart.Name -}}
{{- end -}}

{{/* 
Secret name for jwt secret
*/}}
{{- define "app.wtsecrets.secretName" -}}
{{- printf "app-%s-jwt-secret-name" .Chart.Name -}}
{{- end -}}

{{- define "app.jwtsecrets.external.secretName" -}}
{{- printf "app-%s-jwtsecrets-external-secret-name" .Chart.Name -}}
{{- end -}}

{{- define "app.jwtsecrets.internal.secretName" -}}
{{- printf "app-%s-jwtsecrets-internal-secret-name" .Chart.Name -}}
{{- end -}}
