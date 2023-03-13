{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $namespaceName, $namespaceTpl := .Values.namespaces -}}
{{ include "sthings-k8s-toolkit.namespace" (list $envVar $namespaceName $namespaceTpl) }}
{{ end -}}
*/}}

{{- define "sthings-k8s-toolkit.namespace" -}}
{{- $envVar := first . -}}
{{- $namespaceName := index . 1 -}}
{{- $namespace := index . 2 -}}
---
apiVersion: v1
kind: Namespace
metadata:
  name: {{ $namespace.name }}
{{- if $namespace.annotations }}
  annotations:
  {{- range $key, $value := $namespace.annotations }}
    {{ $key }}: {{ $value | quote }}
{{- end }}{{- end }}
{{- if $namespace.labels }}
  labels:
    {{- toYaml $namespace.labels | nindent 4  }}{{- end }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: basic-namespace
    values: |
      namespaces:
        sthings-base:
          name: sthings-base:
          labels:
            app: sthings-base 
          #annotations:
            #field.cattle.io/projectId: c-m-4hrvdmsk:p-wcb6d
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}