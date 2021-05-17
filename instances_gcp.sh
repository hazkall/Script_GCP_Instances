#!/bin/bash

#GCP variables

export project=""
export zone=""
export machine=""
export subnet=""
export image=""
export instances=2 #Number of instances



function getGCPCompute { 

  list=$(gcloud beta compute --project=$project instances list --format=json | egrep '"name": "cka-node-.*"' | wc -l)

  if [  $list -gt 0 ]; then 


     n=$(gcloud beta compute --project=$project instances list --format=json | egrep '"name": "cka-node-.*"' | wc -l)
   
  else

    n=0 

  fi 
  
  return $n 

  }



if getGCPCompute;[ $instances -gt $n ]; then

    echo "Creating $(($instances -$n)) instance[s]"
    for i in `seq $((instances-n))`;do
        
        gcloud beta compute \
            --project=cka-cloud-native \
            instances create cka-node-$RANDOM \
            --zone=$zone \
            --machine-type=$machine\
            --subnet=$subnet \
            --network-tier=STANDARD \
            --maintenance-policy=MIGRATE \
            --image=$image \
            --image-project=ubuntu-os-cloud \
            --boot-disk-size=10GB \
            --boot-disk-type=pd-balanced \
            --boot-disk-device-name=cka-cluster \
            --no-shielded-secure-boot \
            --shielded-vtpm \
            --shielded-integrity-monitoring \
            --reservation-affinity=any

    done

else

  echo "Machines already created on Google Cloud"

fi

