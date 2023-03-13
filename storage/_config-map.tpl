{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $configmapName, $configmapTpl := .Values.configmaps -}}
{{ include "sthings-k8s-toolkit.configmap" (list $envVar $configmapName $configmapTpl) }}
{{ end -}}
*/}}

{{- define "sthings-k8s-toolkit.configmap" -}}
{{- $envVar := first . -}}
{{- $configmapName := index . 1 -}}
{{- $configmapTpl := index . 2 -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configmapName }}
  namespace: {{ $envVar.Values.namespace }}
data:
{{- if kindIs "map" $configmapTpl -}}
{{- tpl (toYaml $configmapTpl) $envVar | nindent 2 }}
{{ else }}
{{ tpl $configmapTpl $envVar | indent 2 }}
{{- end }}
{{- end }}

{{/*
# exampleValues:
examples:
  - name: basic-configmap
    values: |
      configmaps:
        sthings-k8s-operator-manager-config:
          controller_manager_config.yaml: |
            apiVersion: controller-runtime.sigs.k8s.io/v1alpha1
            kind: ControllerManagerConfig
            health:
              healthProbeBindAddress: :6789
            metrics:
              bindAddress: 127.0.0.1:8080
            leaderElection:
              leaderElect: true
              resourceName: 811c9dc5.stuttgart-things.sthings.tiab.ssc.sva.de
*/}}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
