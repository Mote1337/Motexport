TOKEN=xxxxx
ENDPOINT=xxxxx
PORT=8443
NAMESPACE=xxxxxx
NOME_DC_1=xxxxx
PRM="?export"

curl -k \
    -H "Authorization: Bearer $TOKEN" \
    -H 'Accept: application/json' \
    https://$ENDPOINT:$PORT/apis/apps.openshift.io/v1/namespaces/$NAMESPACE/deploymentconfigs/$NOME_DC_1$PRM | \
    jq '.spec.template.spec.containers[] .name'
