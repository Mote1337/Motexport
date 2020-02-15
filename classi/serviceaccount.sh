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