TOKEN=0l6X5sdBvK3Pwo0Q1-kHy53ROTVqBVeNQUnJ3vXPR_M
ENDPOINT=master.svil2.ocprm.testposte
PORT=8443
NAMESPACE=frontendlibretti
NOME_DC_1=libretti-aperture-associazioneruoli

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