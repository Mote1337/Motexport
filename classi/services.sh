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