pipeline {
    agent any

    tools {
        maven "M3"
    }

    stages {
        stage('Build') {
            steps{
                git 'https://github.com/hiashutosh/devops.git'
                sh "mvn clean install package"
            }

            post{
                success {
                    junit '**target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'

                }
            }
            
        }
    }
}