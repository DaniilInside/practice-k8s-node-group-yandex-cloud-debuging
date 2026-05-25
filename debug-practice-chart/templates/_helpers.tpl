{{/*
Get namespace.create value with default
*/}}
{{- define "debug-practice-chart.namespace.create" -}}
{{- if .Values.namespace }}
{{- .Values.namespace.create | default true }}
{{- else }}
{{- false }}
{{- end }}
{{- end }}

{{/*
Get namespace.name value with default
*/}}
{{- define "debug-practice-chart.namespace.name" -}}
{{- if .Values.namespace }}
{{- .Values.namespace.name | default "" }}
{{- else }}
{{- "" }}
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "debug-practice-chart.name" -}}
{{- default .Chart.Name (include "debug-practice-chart.namespace.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "debug-practice-chart.fullname" -}}
{{- if include "debug-practice-chart.namespace.name" . }}
{{- (include "debug-practice-chart.namespace.name" .) | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "debug-practice-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "debug-practice-chart.labels" -}}
helm.sh/chart: {{ include "debug-practice-chart.chart" . }}
{{ include "debug-practice-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "debug-practice-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "debug-practice-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Define the namespace name
*/}}
{{- define "debug-practice-chart.namespace" -}}
{{- if include "debug-practice-chart.namespace.create" . }}
{{- include "debug-practice-chart.fullname" . }}
{{- else }}
{{- default "default" (include "debug-practice-chart.namespace.name" .) }}
{{- end }}
{{- end }}
