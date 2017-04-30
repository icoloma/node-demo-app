#!groovy

/*

  Copyright 2015 Google Inc. All rights reserved.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License

*/

node {

  currentBuild.result = "SUCCESS"

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

      print "Publishing container to gcr.io/${env.GCP_PROJECT}/node-demo-app"

      // capture package version
      // http://stackoverflow.com/questions/36507410/is-it-possible-to-capture-the-stdout-from-the-sh-dsl-command-in-the-pipeline 
      env.PACKAGE_VERSION=sh(returnStdout: true, script: 'node -p -e "require(\'./package.json\').version"').trim()

      sh "gcloud config set core/project icoloma-42"
      sh "gcloud auth activate-service-account jenkins-demo-service-account@icoloma-42.iam.gserviceaccount.com --key-file=/var/run/secrets/jenkins-demo-secrets/jenkins-demo-service-account.json"
      sh "gcloud container builds submit . --tag gcr.io/icoloma-42/node-demo-app:${PACKAGE_VERSION} --tag gcr.io/icoloma-42/node-demo-app:latest"
    }

    stage('Deploy') {

      sh 'gcloud container clusters get-credentials demo-prod'
      sh 'kubectl get pods' 

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