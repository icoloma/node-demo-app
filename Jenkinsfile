#!groovy

/**

  Example pipeline to deploy this application. Will behave differently depending on the branch it is run on.
  For an alternative example, see 
  https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes/blob/master/sample-app/Jenkinsfile

*/
node {

  currentBuild.result = "SUCCESS"
  def PROJECT = 'extrema-demos'
  def ZONE = 'europe-west1-c'
  def IMAGE_TAG = "gcr.io/${PROJECT}/node-demo-app:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"

  // checkout sources
  checkout scm

  try {
  
    stage('Test') {

      // run all tests in package.json
      sh 'node -v'
      sh 'npm install --no-color'
      sh 'NODE_ENV=test npm test --no-color'

    }

    stage('Build Docker') {

      print "Publishing container to gcr.io/${PROJECT}/node-demo-app"

      sh "gcloud config set core/project ${PROJECT}"
      sh "gcloud config set compute/zone ${ZONE}"
      sh "gcloud auth activate-service-account jenkins-demo-service-account@${PROJECT}.iam.gserviceaccount.com --key-file=/var/run/secrets/jenkins-demo-secrets/jenkins-demo-service-account.json"
      sh "gcloud container builds submit . --tag ${IMAGE_TAG}"
    }

    stage('Deploy') {

      if (env.BRANCH_NAME == "release") {
        // alternative deployment pipeline for production
      } else {
        sh 'gcloud container clusters get-credentials demo-dev'
        sh "sed -i.bak 's#gcr.io/${PROJECT}/node-demo-app:1.0.0#${IMAGE_TAG}#' k8s/app-deployment.yaml"
        sh "kubectl apply -f k8s/app-deployment.yaml"
        sh "kubectl apply -f k8s/app-service.yaml"
        sh "echo http://`kubectl get service/node-demo-service --output=json | jq -r '.status.loadBalancer.ingress[0].ip'`"
      }

    }

  } catch (err) {

    currentBuild.result = "FAILURE"
    // mail body: "project build error is here: ${env.BUILD_URL}" ,
    // from: 'xxxx@yyyy.com',
    // replyTo: 'yyyy@yyyy.com',
    // subject: 'project build failed',
    // to: 'zzzz@yyyyy.com'

    throw err
  }

}
