#!/bin/bash

for version in v0-10-0-2 v0-11-0-3 v1-0-2 v2-0-1 v2-1-0; do
    standalone_output_file="standalone_${version}.yaml"
    string_version=$(echo "$version" | tr '-' '.' | cut -c 2-)
    sed "s/{{VERSION}}/${version}/g; s/{{STRING_VERSION}}/${string_version}/g" standalone.tpl > ../standalone/${standalone_output_file}
done

