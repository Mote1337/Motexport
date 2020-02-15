#Build Config

buildconfig(){
bc=( $(oc get buildconfigs -o name -n $1) )

if [ ${#bc[@]} -gt 0 ]
then
        {
                echo "Esistono [${#bc[@]}] Build Config in $1"
                echo "Creazione cartella buildconfigs"
                mkdir buildconfigs
                echo "Inizio copia dei Build Config"
                n=0
                for i in $(oc get buildconfigs -o name -n $1);do oc get --export -o yaml $i -n $1 > $i.yaml;let n=$n+1;echo "[$n]Build Config copiato: $i";done
        }
else
        {
		echo "Nel project $1 non esistono Build Config (Forse non è un sistema di Sviluppo!)"
        }
fi
}