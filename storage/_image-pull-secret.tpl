{{- define "sthings-k8s-toolkit.imagePullSecret" -}}
{{- $envVar := first . -}}
{{- $imagePullSecretName := index . 1 -}}
{{- $imagePullSecret := index . 2 -}}
{{- $registryUrl := $imagePullSecret.registry }}
{{- $registryUser := $imagePullSecret.username }}
{{- $registryPassword := $imagePullSecret.password }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ $imagePullSecretName }}
  namespace: {{ $imagePullSecret.namespace | default $envVar.Values.namespace }}
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: {{ include "sthings-k8s-toolkit.dockerConfigJson" (list $registryUrl $registryUser $registryPassword) }}
{{- end }}
