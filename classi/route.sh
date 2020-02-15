#!/bin/bash

## Motexport ( https://github.com/Mote1337/Motexport )
## Realizzato da Paolo Nicolosi ( https://github.com/Mote1337 ) in collaborazione con Silvio D'alessio

#Routes
routes=( $(oc get routes -o name -n $project) )

if [ ${#routes[@]} -gt 0 ]
then
        {
                echo "Esistono [${#routes[@]}] Routes in $project"
                echo "Creazione cartella routes"
                mkdir routes
                echo "Inizio copia delle routes"
                n=0
                for i in $(oc get routes -o name -n $project);do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Routes copiata: $i";done
                echo "ATTENZIONE!! MODIFICARE L'INDIRIZZO DELLA ROTTA PRIMA DI IMPORTARLA!"
        }
else
        {
                echo "Nel project $project non esistono Route"
        }
fi