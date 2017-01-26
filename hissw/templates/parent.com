;include paths for any packages we are loading
{% if ssw_path_list | length > 0 %}
ssw_path,/{{ ssw_path_list | join(', /') }}
{% endif %}
;add any other paths we need to the IDL path
!PATH=!PATH{%for p in extra_paths%}+':'+EXPAND_PATH('{{p}}'){%endfor%}
;run user scripts
{% for s in scripts %}
{{ s }}
{% endfor %}
;save workspace or desired variables
save,{% for var in save_vars %}{{ var }},{% endfor %}filename='{{ save_filename }}'
;exit sswidl
exit
