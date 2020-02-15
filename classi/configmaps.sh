#!/bin/bash

## Motexport ( https://github.com/Mote1337/Motexport )
## Realizzato da Paolo Nicolosi ( https://github.com/Mote1337 ) in collaborazione con Silvio D'Alessio

#Configmaps

configmaps(){
cm=( $(oc get configmaps -o name -n $1) )

if [ ${#cm[@]} -gt 0 ]
then
        {
                echo "Esistono [${#cm[@]}] Configmaps in $1"
                echo "Creazione cartella configmaps"
                mkdir configmaps
                echo "Inizio copia dei configmaps"
                n=0
                for i in $(oc get configmaps -o name -n $1);do oc get --export -o yaml $i -n $1 > $i.yaml;let n=$n+1;echo "[$n]Configmaps copiata: $i";done
        }
else
        {
                echo "Nel project $1 non esistono Config Maps o_O!"
        }
fi
}