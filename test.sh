#!/bin/bash

NAMESPACE=$1

dc=( $(oc get deploymentconfigs -o name -n $NAMESPACE) )

conta_dc=0
conta_container=0

for i in ${dc[@]};
do
    echo "[DEPLOYMENT CONFIG] : ${dc[$conta_dc]} ";

    numero_container=( $(oc get --export -o json $i -n $NAMESPACE | jq '.spec.template.spec.containers[] .name') );

    for y in ${numero_container[@]};
    do  
        cpu_limits=( $(oc get --export -o json $i -n $NAMESPACE | jq --argjson num $conta_container '.spec.template.spec.containers[$num] .resources.limits.cpu') )
        memory_limits=( $(oc get --export -o json $i -n $NAMESPACE | jq --argjson num $conta_container '.spec.template.spec.containers[$num] .resources.limits.memory') )
        cpu_requests=( $(oc get --export -o json $i -n $NAMESPACE | jq --argjson num $conta_container '.spec.template.spec.containers[$num] .resources.requests.cpu') )
        memory_requests=( $(oc get --export -o json $i -n $NAMESPACE | jq --argjson num $conta_container '.spec.template.spec.containers[$num] .resources.requests.memory') )
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
