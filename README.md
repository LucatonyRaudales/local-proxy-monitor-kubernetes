# local-proxy-monitor-kubernetes
A project that use terraform and microk8s to setup a kubernetes clustr that have 3 pods with loadbalancer, proxy and monitoring
install microk8s
install multipass


first:
Install kind, microk8s, etc.. 
In this case I will use Kinds 'cause it use Docker to exist...

To create the cluster with Kind just run: Kind create cluster

Nice, now we need to install the Kubernetes CLI (Kubectl) running the following command: brew install kubernetes-cli

To update the kube context just run: kubectl cluster-info --context kind-kind

You must got an output something like this message: 
Kubernetes control plane is running at https://127.0.0.1:52123
CoreDNS is running at https://127.0.0.1:52123/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.


Running the command: kubectl get nodes, we verify that all works fine getting the following message:
NAME                 STATUS   ROLES           AGE     VERSION
kind-control-plane   Ready    control-plane   5m25s   v1.27.3


In this opportunity we will use two ways to access to our cluster through load balancer.
First, we will use metallb.
To do it, we will use Kustomize to run native kubernetes configuration manifest.
Run this command to install kustomize: 
    brew install kustomize

before apply the metallb configuration, we need to know some range of our LAN to say to metallb "Hey, u can use some of the following IP and attach it to the load balancer".
If you have the available ip range of your LAN, you must paste it in the 'configmap.yaml' file and replace this "192.168.1.220-192.168.1.230" with your range"

Now run this command to build the configuration and apply it:
kustomize build . | kubectl apply  -f -

The above command creates the ip address pool that metallb will use to assign the IP address to our load balancer.
To get the information of the Ip Adress pool run this command: kubectl get IPAddressPools -n metallb-system
We need to run the kubernetes manifest, so run this command to install terraform:
brew install terraform

Having terraform installed we need run the following command to apply the terraform configuration:



--Con el video
kubectl edit configmap -n kube-system kube-proxy
..
- kubectl api-resources | grep metallb
- kubectl -n metallb-system apply -f pool.yaml
- kubectl get -n metallb-system IPAddressPool
- kubectl apply -f advertisement.yaml
- kubectl -n metallb-system get l2advertisement