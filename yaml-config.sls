{% import_yaml slspath~'/config.yaml' as config %}

"Install":
  pkg.installed:
    - name: {{ config.pkg }}
    - version: {{ config.version }}
    
    
