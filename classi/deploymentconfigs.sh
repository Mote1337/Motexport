#!/bin/bash

## Motexport ( https://github.com/Mote1337/Motexport )
## Realizzato da Paolo Nicolosi ( https://github.com/Mote1337 ) in collaborazione con Silvio D'Alessio

#Deployment Config

export_deploymentconfigs(){
dc=( $(oc get deploymentconfigs -o name -n $1) )

if [ ${#dc[@]} -gt 0 ]
then
	{
		echo "Esistono [${#dc[@]}] Deployment Config in $1"
		echo "Creazione cartella deploymentconfigs"
		mkdir deploymentconfigs
		echo "Inizio copia dei dc"
		n=0
		for i in $(oc get deploymentconfigs -o name -n $1);do oc get --export -o yaml $i -n $1 > $i.yaml;let n=$n+1;echo "[$n]Deployment Config copiato: $i";done
	}
else
	{
		echo "Nel project $1 non esistono Deployment Config"
	}
fi
}

report_deploymentconfig(){
	dc=( $(oc get deploymentconfigs -o name -n $1) )

	containers=( $(oc get --export -o json ${dc[1]} | jq '.spec.template.spec.containers[] .name') )

	 echo "Mi ritornano 2 valori da qui? ${#containers[@]}, VALORE 1: ${containers[0]} ---- VALORE2: ${containers[1]} --------- "
	if [ ${#dc[@]} -gt 0 ]
		then
		{
			echo "Esistono [${#dc[@]}] Deployment Config in $1"
			# Ciclo for per leggere il DC, quanti Container i Limit e Requests

			#Ok.... usando jq tiro fuori tutto quello che mi serve. Domani devo fare dei cicli for che con il conteggio di quanti container ci sono
			# si fanno il giro e prendono tutto, ora devo fare le jq che tirano fuori i limits e tutto
			n=0
			for i in $(oc get deploymentconfigs -o name -n $1);do let n=$n+1; echo "Il [$n] Deployment Config si chiama $i"; echo "Il Deployment Config è ${#containers[@]} Containers";echo ${containers[@]};done
		}
		else
		{
			echo "Nel project $1 non esistono Deployment Config"
		}
	fi
}