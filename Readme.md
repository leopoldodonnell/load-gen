# load-gen

A simple load generator for kubernetes using helm.

There are times when you just want to generate some background load to stress-test your software on a cluster. This is especially
useful when you're looking to test the scale out and in properties of your cluster as you deploy and load-test applications.

This chart is really quite simple. It uses a short ruby script in a configmap that gets mounted and run on a ruby-alpine image.
The current defaults will genereate about a 1000 milli-cpu load on an m3-large EC2 instance, so simply multiplying the number of
replicas will map pretty evenly to CPUs.

**To Install**

1. Setup your KUBECONFIG
1. Clone this repository
1. Run the following

    > helm install load-gen --name load-gen --set replicaCount={how many cpus}

