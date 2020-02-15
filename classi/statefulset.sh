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