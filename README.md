# NodeJS-Image-Upload

## I'm trying to connect Persistent volume in ImageUpload nodeapp

We just need to follow shell files instruction.

You have to go this directory . test

```
cd /HowToRun/GKE
```

Now just run the normal file to create cluster seprately createClusterIfNeeded.sh.

```
sh createClusterIfNeeded.sh
```

And if you want to create cluster with gCloudDeployment same time you can run the shell file 

```
sh gCloudDeployment.sh
``` 

You will get port at last just run that port and upload the image.

Now we have to check the pod is store the data or not so for that we need to do one thing 

1) After upload the image first login to the pod then do confirm the image is there. Let's login the pod with this command

```
kubectl exec -it << POD_NAME >> -- /bin/bash
```
Now confirm that image is there.

2) Now you have to delete the pod with this command

``` 
kubectl delete po << POD_NAME >>
```
3) Now reapply the pod and confirm that image is still there even pod deleted. Again login to the pod and check it out.

If the image is there then your nodeapp is working with persistent volume.

Thank you :)
