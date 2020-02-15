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