{{/*
Generate the fullname for the resources in this chart.
*/}}
{{- define "cosmocloud-deploy.fullname" -}}
{{- .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{/*
Generate the name of the chart.
*/}}
{{- define "cosmocloud-deploy.chartName" -}}
{{- .Chart.Name }}
{{- end }}

{{/*
Generate common labels for all resources.
*/}}
{{- define "cosmocloud-deploy.labels" -}}
app.kubernetes.io/name: {{ include "cosmocloud-deploy.chartName" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}