{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $serviceAccountName, $serviceAccount := .Values.serviceAccounts -}}
{{ include "sthings-k8s-toolkit.service-account" (list $envVar $serviceAccountName $serviceAccount) }}
{{ end -}}
*/}}

{{- define "sthings-k8s-toolkit.service-account" -}}
{{- $envVar := first . -}}
{{- $serviceAccountName := index . 1 -}}
{{- $serviceAccount := index . 2 -}}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ $serviceAccountName }}
  namespace: {{ $serviceAccount.namespace | default $envVar.Values.namespace }}
  labels:
    {{- toYaml $serviceAccount.labels | nindent 4  }}
{{- end -}}

{{/*
# exampleValues:
---
serviceAccounts:
  pipeline-run-cleaner:
    labels:
      app: sthings-tekton
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
