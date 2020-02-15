#!/bin/bash

echo "Inserire il nome del progetto: "
read project

# Controllo argomento obbligatorio: NAMESPACE
if [ -z $project ]
then
        echo "Devi inserire il nome del progetto!"
        exit
else
	mkdir $project
	cd $project
fi

#Build Config
bc=( $(oc get buildconfigs -o name -n $project) )

if [ ${#bc[@]} -gt 0 ]
then
        {
                echo "Esistono [${#dc[@]}] Build Config in $project"
                echo "Creazione cartella buildconfigs"
                mkdir buildconfigs
                echo "Inizio copia dei Build Config"
                n=0
                for i in $(oc get buildconfigs -o name -n $project);do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Build Config copiato: $i";done
        }
else
        {
		echo "Nel project $project non esistono Build Config (Forse non è un sistema di Sviluppo!)"
        }
fi

#Deployment Config
dc=( $(oc get deploymentconfigs -o name -n $project) )

if [ ${#dc[@]} -gt 0 ]
then
	{
		echo "Esistono [${#dc[@]}] Deployment Config in $project"
		echo "Creazione cartella deploymentconfigs"
		mkdir deploymentconfigs
		echo "Inizio copia dei dc"
		n=0
		for i in $(oc get deploymentconfigs -o name -n $project);do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Deployment Config copiato: $i";done
	}
else
	{
		echo "Nel project $project non esistono Deployment Config"
	}
fi

#Statefulset
sts=( $(oc get statefulsets -o name -n $project) )

if [ ${#sts[@]} -gt 0 ]
then
        {
                echo "Esistono [${#sts[@]}] Statefulset in $project"
                echo "Creazione cartella statefulset"
                mkdir statefulsets
                echo "Inizio copia dei dc"
		n=0
                for i in $(oc get statefulsets -o name -n $project);do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Statefulset copiato: $i";done
        }
else
        {
                echo "Nel project $project non esistono Statefulset"
        }
fi

#Services
svc=( $(oc get services -o name -n $project) )

if [ ${#svc[@]} -gt 0 ]
then
        {
                echo "Esistono [${#svc[@]}] Services in $project"
                echo "Creazione cartella services"
                mkdir services
                echo "Inizio copia dei svc"
                n=0
                for i in $(oc get services -o name -n $project);do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Services copiato: $i";done
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
cm=( $(oc get configmaps -o name -n $project) )

if [ ${#cm[@]} -gt 0 ]
then
        {
                echo "Esistono [${#cm[@]}] Configmaps in $project"
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
sa=( $(oc get serviceaccounts -o name -n $project | grep -v builder | grep -v default | grep -v deployer ) )

if [ ${#sa[@]} -gt 0 ]
then
        {
                echo "Esistono [${#sa[@]}] Service Account CUSTOM in $project"
                echo "Creazione cartella serviceaccounts"
                mkdir serviceaccounts
                echo "Inizio copia dei serviceaccounts"
                for i in $(oc get serviceaccounts -o name -n $project | grep -v builder | grep -v default | grep -v deployer );do oc get --export -o yaml $i -n $project > $i.yaml;let n=$n+1;echo "[$n]Service Account copiato: $i";done
        }
else
        {
                echo "Nel project $project non esistono Service Account custom"
        }
fi
