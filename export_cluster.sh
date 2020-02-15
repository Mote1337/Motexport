#!/bin/bash

dir=$PWD
project=( $(oc get project -o custom-columns=NAME:.metadata.name | grep -v NAME) )

for project in $(oc get project -o custom-columns=NAME:.metadata.name | grep -v NAME);do {
        mkdir $dir/$project
        cd $dir/$project
#Deployment Config
dc=( $(oc get dc -o name -n $project) )

if [ ${#dc[@]} -gt 0 ]
then
	{
		echo "Esistono [${#dc[@]}] Deployment Config in $project"
		echo "Creazione cartella deploymentconfigs"
		mkdir deploymentconfigs
		echo "Inizio copia dei dc"
		n=0
		for i in $(oc get dc -o name -n $project);do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Deployment Config copiato: $i";done
	}
else
	{
		echo "Nel project $project non esistono Deployment Config"
	}
fi

#DaemonSets
ds=( $(oc get ds -o name -n $project) )

if [ ${#ds[@]} -gt 0 ]
then
	{
		echo "Esistono [${#ds[@]}] DaemonSets in $project"
		echo "Creazione cartella daemonsets"
		mkdir daemonsets
		echo "Inizio copia dei ds"
		n=0
		for i in $(oc get ds -o name -n $project);do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]DaemonSets copiato: $i";done
	}
else
	{
		echo "Nel project $project non esistono DaemonSets"
	}
fi

#Statefulset
sts=( $(oc get sts -o name -n $project) )

if [ ${#sts[@]} -gt 0 ]
then
        {
                echo "Esistono [${#sts[@]}] Statefulset in $project"
                echo "Creazione cartella statefulset"
                mkdir statefulsets
                echo "Inizio copia dei dc"
		n=0
                for i in $(oc get sts -o name -n $project);do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Statefulset copiato: $i";done
        }
else
        {
                echo "Nel project $project non esistono Statefulset"
        }
fi

#Services
svc=( $(oc get svc -o name -n $project) )

if [ ${#svc[@]} -gt 0 ]
then
        {
                echo "Esistono [${#svc[@]}] Services in $project"
                echo "Creazione cartella services"
                mkdir services
                echo "Inizio copia dei svc"
                n=0
                for i in $(oc get svc -o name -n $project);do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Services copiato: $i";done
        }
else
        {
                echo "Nel project $project non esistono Services"
        }
fi

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

#Configmaps
configmaps=( $(oc get configmaps -o name -n $project) )

if [ ${#configmaps[@]} -gt 0 ]
then
        {
                echo "Esistono [${#configmaps[@]}] Configmaps in $project"
                echo "Creazione cartella configmaps"
                mkdir configmaps
                echo "Inizio copia dei configmaps"
                n=0
                for i in $(oc get configmaps -o name -n $project);do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Configmaps copiata: $i";done
        }
else
        {
                echo "Nel project $project non esistono Config Maps o_O!"
        }
fi

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

#Service Account
sa=( $(oc get sa -o name -n $project | grep -v builder | grep -v default | grep -v deployer ) )

if [ ${#sa[@]} -gt 0 ]
then
        {
                echo "Esistono [${#sa[@]}] Service Account CUSTOM in $project"
                echo "Creazione cartella serviceaccounts"
                mkdir serviceaccounts
                echo "Inizio copia dei serviceaccounts"
                n=0
                for i in $(oc get sa -o name -n $project | grep -v builder | grep -v default | grep -v deployer );do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Service Account copiato: $i";done
        }
else
        {
                echo "Nel project $project non esistono Service Account custom"
        }
fi
}
#Cronjobs
cronjobs=( $(oc get cronjobs -o name -n $project) )

if [ ${#cronjobs[@]} -gt 0 ]
then
        {
                echo "Esistono [${#cronjobs[@]}] Cronjobs in $project"
                echo "Creazione cartella cronjobs"
                mkdir cronjobs
                echo "Inizio copia dei cronjobs"
                n=0
                for i in $(oc get cronjobs -o name -n $project);do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Cronjobs copiato: $i";done
        }
else
        {
                echo "Nel project $project non esistono Cronjobs"
        }
fi;done
