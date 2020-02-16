TOKEN=xxxxxxxxx
ENDPOINT=xxxxxxxxxx
PORT=8443
NAMESPACE=xxxxxxxxxxx
NOME_DC_1=xxxxxxxxx

curl -k \
    -H "Authorization: Bearer $TOKEN" \
    -H 'Accept: application/yaml' \
    https://$ENDPOINT:$PORT/apis/apps.openshift.io/v1/deploymentconfigs \
    --progress-bar \
    --output prova2

echo "PAUSAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

curl -k \
    -H "Authorization: Bearer $TOKEN" \
    -H 'Accept: application/yaml' \
    https://$ENDPOINT:$PORT/apis/apps.openshift.io/v1/namespaces/$NAMESPACE/deploymentconfigs

echo "PAUSAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

curl -k \
    -H "Authorization: Bearer $TOKEN" \
    -H 'Accept: application/yaml' \
    -H 'pretty: true' \
    https://$ENDPOINT:$PORT/apis/apps.openshift.io/v1/namespaces/$NAMESPACE/deploymentconfigs/$NOME_DC_1 \
    --output prova
