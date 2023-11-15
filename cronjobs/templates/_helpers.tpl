

{{- define "cronjobs.getscripts" -}}
{{- range $index, $_ := $.Files.Glob "script/**.sh" }}
{{ $lindex:= len $index }}
{{- printf "%s" $index | substr 7 $lindex | nindent 2 }} : | 
{{- printf "%s" $_ | nindent 4 }}
{{- end -}}
{{- end -}}




{{- define "cronjobs.getEnv" -}}
{{ if or (.Values.cronjob.environment_variables) (.Values.cronjob.environment_variables)}} 
            env:
{{- end -}}            
{{ if .Values.cronjob.environment_variables }} 
            {{- range $e := .Values.cronjob.environment_variables }}
            - name: {{ $e.name }}
              value: {{ $e.env_value }}
            {{- end }}
{{- end -}}
{{- if .Values.cronjob.secrets }} 
            {{- range $s := .Values.cronjob.secrets }}
            - name: {{ $s.secret }}
              valueFrom:
                secretKeyRef: 
                  name: {{ $s.secret_name }}
                  key: {{ $s.secret_value }}
            {{- end }}
{{- end -}}            
{{- end -}}

{{- define "cronjobs.getvolumeMounts" -}}
            volumeMounts:
            {{- range $vm := .Values.cronjob.volume_mounts }}
            - mountPath: "{{ .Values.cronjob.volume_mounts.script_path }}/{{ .Values.cronjob.volume_mounts.script_name }}"
              name: {{ .Values.cronjob.volume_mounts.name }}-config
              subPath: "{{ .Values.cronjob.script.script_name }}"
            {{- end }}
{{- end -}}