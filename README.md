# Script to Create Instances on GCP

This script creates instances on GCP

## Pre-req

To run gcloud commands, you need the GCP SDK.

Guide to install:

<https://cloud.google.com/sdk/docs/install>

Now just do login on gcp

```sh

gcloud init

```

To create instances you need to a VPC, use the follow command:

```sh


gcloud compute networks create "network-name" \
--project="your-project" \
--subnet-mode=auto \
--mtu=1460 \
--bgp-routing-mode=regional

#IF you need create a Firewall
#This is just a sample
gcloud compute --project="your-project" \
firewall-rules create "rules-name" \
--direction=INGRESS \
--priority=1000 \
--network=cka-k8s \
--action=ALLOW \
--rules=all \
--source-ranges=0.0.0.0/0

```

## Usage

On script just fullfil the gcp variables

```sh

#Get subnet

gcloud compute networks describe "your network-name"

export project=""
export zone="" 
export machine="" # resource machine type on gcp
export subnet=""
export image="" #instance image, sample -> ubuntu
export instances=2 #Number of instances

# Now just:

chmod +x instances_gcp.sh
./instances_gcp.sh
```
