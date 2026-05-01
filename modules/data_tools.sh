#!/bin/bash
# ============================================================================
# Module: Data Tools
# Description: Ghee shortcuts and utilities for Data Tools.
# ============================================================================

# JSON / YAML / Data Processing

_GG_REGISTRY["jqpp"]="cat file.json | jq . ||| Pretty-print JSON"
_GG_REGISTRY["jqkeys"]="jq 'keys' ||| List top-level JSON keys"
_GG_REGISTRY["jqlen"]="jq 'length' ||| Get length of JSON array or object"
_GG_REGISTRY["jqm"]="jq 'map(.FIELD)' ||| Map/extract a field from JSON array"
_GG_REGISTRY["jqsel"]="jq '.[] | select(.key==val)' ||| Filter JSON array by field value"
_GG_REGISTRY["yamlcheck"]="python3 -c yaml.safe_load ||| Validate YAML file syntax"
_GG_REGISTRY["yaml2json"]="python3 yaml to json ||| Convert YAML file to JSON"
_GG_REGISTRY["json2yaml"]="python3 json to yaml ||| Convert JSON file to YAML"
_GG_REGISTRY["csvhead"]="head -1 FILE.csv | tr ',' '\n' ||| Show CSV column headers"
_GG_REGISTRY["csvcol"]="cut -d, -f N FILE.csv ||| Extract column N from CSV"
_GG_REGISTRY["sortjson"]="jq 'sort_by(.KEY)' ||| Sort JSON array by a key"

# Pretty-print JSON from file or stdin
alias jqpp='jq .'

# Get keys
alias jqkeys='jq "keys"'

# Get length
alias jqlen='jq "length"'

# Validate YAML
yamlcheck() {
    if [ -z "$1" ]; then echo "Usage: yamlcheck <file.yaml>"; return 1; fi
    python3 -c "import yaml, sys; yaml.safe_load(open('$1'))" && echo "✓ Valid YAML" || echo "✗ Invalid YAML"
}

# Convert YAML to JSON
yaml2json() {
    if [ -z "$1" ]; then echo "Usage: yaml2json <file.yaml>"; return 1; fi
    python3 -c "
import yaml, json, sys
with open('$1') as f:
    data = yaml.safe_load(f)
print(json.dumps(data, indent=2))
"
}

# Convert JSON to YAML
json2yaml() {
    if [ -z "$1" ]; then echo "Usage: json2yaml <file.json>"; return 1; fi
    python3 -c "
import yaml, json, sys
with open('$1') as f:
    data = json.load(f)
print(yaml.dump(data, default_flow_style=False))
"
}

# CSV column headers
csvhead() {
    if [ -z "$1" ]; then echo "Usage: csvhead <file.csv>"; return 1; fi
    head -1 "$1" | tr ',' '\n' | nl
}

# Extract column N from CSV (1-indexed)
csvcol() {
    if [ -z "$2" ]; then echo "Usage: csvcol <file.csv> <column_number>"; return 1; fi
    cut -d',' -f"$2" "$1"
}

# Count lines in a file (excluding header)
csvcount() {
    if [ -z "$1" ]; then echo "Usage: csvcount <file.csv>"; return 1; fi
    echo "$(($(wc -l < "$1") - 1)) rows"
}
