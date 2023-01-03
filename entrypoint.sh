#!/bin/bash

set -eo pipefail

spec="$INPUT_SPEC"
version="$INPUT_VERSION"
hash="$INPUT_HASH"
[[ -z $hash ]] && hash=${GITHUB_SHA:0:7}

if [ -z "$spec" -o  -z "$version" ]; then
  echo "Failed! Missing spec or version."
  exit 1
fi

echo spec=$spec version=$version hash=$hash

readonly RPMBUILD_DIR="${HOME}/rpmbuild"
readonly RPMBUILD_SOURCE_DIR="${RPMBUILD_DIR}/SOURCES"
#readonly RPMBUILD_SPEC_DIR="${RPMBUILD_DIR}/SPECS"
#mkdir -p "${RPMBUILD_SPEC_DIR}"

ls -la 
ls -la  ${RPMBUILD_DIR}

rpmbuild -bb\
    --define "_version ${version}" \
    --define "_hash ${hash}" \
    --define "version ${version}" \
    $spec

RPMS=${RPMBUILD_DIR}/RPMS/$(uname -m)/*.rpm
mv  ${RPMS} .
echo "rpmfile=$(ls *.rpm)" >> $GITHUB_OUTPUT
cat $GITHUB_OUTPUT

