#Storage Classes
sc=( $(oc get storageclasses -o name -n $project) )

if [ ${#sc[@]} -gt 0 ]
then
        {
                echo "Esistono [${#dc[@]}] Storage Classes nel Cluster"
                echo "Creazione cartella storageclasses"
                mkdir storageclasses
                echo "Inizio copia dei Storage Classes"
                n=0
                for i in $(oc get storageclasses -o name );do oc get --export -o yaml $i > $i.yaml;let n=$n+1;echo "[$n]Storage Classes copiato: $i";done
        }
else
        {
		echo "Nel Cluster non esistono Storage Classes"
        }
fi