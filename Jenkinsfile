pipeline {
    agent any 	
	     environment {
		
		            PROJECT_ID = 'empowerinnovate9799'
                CLUSTER_NAME = 'image-upload'
                LOCATION = 'us-east1-b'
                CREDENTIALS_ID = 'kubernetes'
                registry = "piyush9090/image-upload-logic" 
                registryCredential = 'dockerHub' 
                dockerImage = ''		
	     }

    stages {	   
	        stage('Scm Checkout') {            
		          steps {
                  checkout scm
		          }	
          }

	        stage('Build Docker Image') { 
		          steps {
		             sh 'whoami'
                   script {
		                dockerImage = docker.build registry + ":${env.BUILD_ID}"
                   }
              }
	        }
	        stage("Push Docker Image") {
                steps {
                   script {

                      docker.withRegistry( '', registryCredential ) {
                        dockerImage.push("${env.BUILD_ID}")
                      } 

                   }
                }
          }
	   
          stage('Deploy to K8s') { 
                steps{
                   echo "Deployment started ..."
		           sh 'ls -ltr'
		           sh 'pwd'
		           sh "sed -i 's/tagversion/${env.BUILD_ID}/g' resource-manifests/imageUploadDeployment.yaml"
		             
		           echo "Creating Persistent volume & claim"
                   step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'resource-manifests/imageUploadPVC.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])

                   echo "Start Deployment of image upload"
                   step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'resource-manifests/imageUploadDeployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])

                   echo "Start service of image upload"
                   step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'resource-manifests/Image-Upload-logic.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
		           echo "Deployment Finished ..."
                }
   	      }
    }
}