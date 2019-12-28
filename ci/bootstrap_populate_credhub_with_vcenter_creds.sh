#!/bin/bash
set -eu
: "${CREDHUB_VAR_PREFIX:? CREDHUB_VAR_PREFIX must be set}"
echo "Using CredHub prefix: $CREDHUB_VAR_PREFIX"
credhub set -t value -n /concourse/main/${CREDHUB_VAR_PREFIX}_vcenter_user -v $GOVC_USERNAME
credhub set -t password -n /concourse/main/${CREDHUB_VAR_PREFIX}_vcenter_password -w $GOVC_PASSWORD

