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

pipeline {
  agent { docker 'node:6.3' }
  stages {
    stage('test') {
      steps {

        // checkout sources
        checkout scm
        sh "${nodeHome}/bin/node -v"

        env.NODE_ENV = "test"
        print "Environment will be : ${env.NODE_ENV}"

        // run all tests in package.json
        sh 'node -v'
        sh 'npm prune && npm install'
        sh 'npm test'
      }
    }
  }
}
/*
node {


  currentBuild.result = "SUCCESS"

  stage('Prepare environment') {

    // checkout sources
    checkout scm

    // quick test
    //def nodeHome = tool name: 'node-5.10.1', type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'

    // Run inside of node.js image
    //sh('systemctl start docker')
    docker.image('node').inside {
      try {
      
        sh "${nodeHome}/bin/node -v"
        stage('Test') {

          env.NODE_ENV = "test"
          print "Environment will be : ${env.NODE_ENV}"

          // run all tests in package.json
          sh 'node -v'
          sh 'npm prune && npm install'
          sh 'npm test'

        }

        stage('Build Docker') {

          print "Publishing container to gcr.io/${env.GCP_PROJECT}/node-demo-app"

          // capture package version
          // http://stackoverflow.com/questions/36507410/is-it-possible-to-capture-the-stdout-from-the-sh-dsl-command-in-the-pipeline 
          env.PACKAGE_VERSION=sh(returnStdout: true, script: 'node -p -e "require(\'./package.json\').version"').trim()

          sh "gcloud container builds submit . --tag gcr.io/${env.GCP_PROJECT}/node-demo-app --tag version:${PACKAGE_VERSION}"
        }

        stage('Deploy') {

            echo 'Kubernetes deploy goes here'

        }

      } catch (err) {

        currentBuild.result = "FAILURE"
    //      mail body: "project build error is here: ${env.BUILD_URL}" ,
    //      from: 'xxxx@yyyy.com',
    //      replyTo: 'yyyy@yyyy.com',
    //      subject: 'project build failed',
    //      to: 'zzzz@yyyyy.com'
    
        throw err
      }
    }

  }

}
*/