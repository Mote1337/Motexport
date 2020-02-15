#!/bin/bash

## Motexport ( https://github.com/Mote1337/Motexport )
## Realizzato da Paolo Nicolosi ( https://github.com/Mote1337 ) in collaborazione con Silvio D'Alessio

#Secrets
secrets=( $(oc get secrets -o name -n $project| grep -v builder | grep -v default | grep -v deployer | grep -v sa | grep -v token | grep -v dockercfg | grep -v glusterblk ) )

if [ ${#secrets[@]} -gt 0 ]
then
        {
                echo "Esistono [${#secrets[@]}] Secrets CUSTOM in $project"
                echo "Creazione cartella secrets"
                mkdir secrets
                echo "Inizio copia dei secrets"
                n=0
                for i in $(oc get secrets -o name -n $project| grep -v builder | grep -v default | grep -v deployer | grep -v sa | grep -v token | grep -v dockercfg | grep -v glusterblk );do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Secrets copiato: $i";done
        }
else
        {
                echo "Nel project $project non esistono Secrets custom"
        }
fi