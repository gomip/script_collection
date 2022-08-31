#!/bin/bash

function parse_yaml() {
  local prefix=$2
  local s='[[:space:]]*'
  local w='[a-zA-Z0-9_\-]*'
  local fs=$(echo @ | tr @ '\034')

  sed "h;s/^[^:]*//;x;s/:.*$//;y/-/_/;G;s/\n//" $1 |
    sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
      -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" |
    awk -F$fs '{
    indent = length($1)/2;
    vname[indent] = $2;

    for (i in vname) {if (i > indent) {delete vname[i]}}
    if (length($3) > 0) {
        vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
        printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
    }
  }'
}

function get_tag() {
  opt=$1
  res=""
  if [ $opt -eq 1 ]
  then
    res=$(parse_yaml ${PARENT_DIR}/yaml/sample.yaml | grep first_image_tag | cut -d '"' -f 2)
  else
    res=$(parse_yaml ${PARENT_DIR}/yaml/sample.yaml | grep second_image_tag | cut -d '"' -f 2)
  fi
  echo $res
}

# 1. 부모 경로 조회
ROOT_DIR=$(cd $(dirname "$0") | pwd -P)
PARENT_DIR=${ROOT_DIR%/*}

# 2. image 태그 조회
RES=$(get_tag $1)
echo $RES > output_$1.txt