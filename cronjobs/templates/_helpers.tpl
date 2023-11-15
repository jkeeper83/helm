{{- define "cronjobs.getscripts" -}}
{{- range $index, $_ := $.Files.Glob "script/**.sh" }}
{{ $lindex:= len $index }}
{{- printf "%s" $index | substr 7 $lindex | nindent 2 }} : | 
{{- printf "%s" $_ | nindent 4 }}
{{- end -}}
{{- end -}}
