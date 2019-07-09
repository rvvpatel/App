pipeline {
    agent { dockerfile true }
    environment {
        HOME = '.'
    }
    stages {
        stage('Install') { 
            steps {
                sh 'npm install' 
            }
        }
        stage('Build for dev') {
            when {
                expression {
                    return GIT_BRANCH == 'origin/dev'
                }
            }
            steps {
                sh 'ng build --configuration=dev'
                withCredentials(bindings: [sshUserPrivateKey(credentialsId: 'jenkins-ssh-key', \
                                                           keyFileVariable: 'KEY_FILE')]) {
                    sh "eval `ssh-agent -s` && ssh-add ${KEY_FILE}"
                    sh 'scp -r dist/* root@169.48.27.167:/s3/dev-frontend'
                }
            }
        }
        stage('Build for testing') {
            when {
                expression {
                    return GIT_BRANCH == 'origin/testing'
                }
            }
            steps {
                sh 'ng build --configuration=testing'
                sh 'scp -o "ProxyCommand ssh root@169.48.27.167 -W %h:%p" -o StrictHostKeyChecking="no" -r dist/* root@10.166.99.29:/var/www/html/'
            }
        }
        stage('Build for production') {
            when {
                expression {
                    return GIT_BRANCH == 'origin/master'
                }
            }
            steps {
                sh 'ng build --prod'
                sh 'scp -o "ProxyCommand ssh ubuntu@ec2-35-182-71-226.ca-central-1.compute.amazonaws.com -W %h:%p" -o StrictHostKeyChecking="no" -r dist/* ubuntu@10.0.130.78:/var/www/html/'
            }
        }
    }
}
