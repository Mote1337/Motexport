#!/bin/bash


NAMESPACE=XXXX


dc=( $(oc get deploymentconfigs -o name -n $NAMESPACE) )

#prova=( $(for i in ${dc[@]};do oc get --export -o json $i | jq '.spec.template.spec.containers[] .name';done) )


#echo "Numero dei dc ${#dc[@]}"
#echo "${dc[@]}"
#echo "Numero dei containers all'interno di tutti i dc ${#prova[@]}"

conta_dc=0
conta_container=0
for i in ${dc[@]};
do
    echo "[DEPLOYMENT CONFIG] : ${dc[$conta_dc]} ";

    containers=( $(oc get --export -o json $i | jq '.spec.template.spec.containers[]') )
    numero_container=( $(oc get --export -o json $i | jq '.spec.template.spec.containers[] .name') );

    for y in ${numero_container[@]};
    do  
        cpu_limits=( $(oc get --export -o json $i | jq --argjson num $conta_container '.spec.template.spec.containers[$num] .resources.limits.cpu') )
        memory_limits=( $(oc get --export -o json $i | jq --argjson num $conta_container '.spec.template.spec.containers[$num] .resources.limits.memory') )
        cpu_requests=( $(oc get --export -o json $i | jq --argjson num $conta_container '.spec.template.spec.containers[$num] .resources.requests.cpu') )
        memory_requests=( $(oc get --export -o json $i | jq --argjson num $conta_container '.spec.template.spec.containers[$num] .resources.requests.memory') )
        echo "[CONTAINER] : ${numero_container[$conta_container]}";
        echo "  Limits:";
        echo "      CPU: $cpu_limits";
        echo "      Memory: $memory_limits";
        echo "  Requests:";
        echo "      CPU: $cpu_requests";
        echo "      Memory: $memory_requests";
        
        let conta_container=$conta_container+1
    done

    conta_container=0
    let conta_dc=$conta_dc+1
done











