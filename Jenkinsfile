pipeline {
    agent { dockerfile true }
    environment {
        HOME = '.'
    }
    stages {
        stage('Install') { 
            steps {
                sh 'cat /etc/os-release'
                sh 'npm install' 
            }
        }
        stage('Build') {
            when {
                expression {
                    return GIT_BRANCH == 'origin/master'
                }
            }
            steps {
                sh 'ng build --prod'
            }
        }
      	stage('Deploy on server') {
            when {
                expression {
                    return GIT_BRANCH == 'origin/master'
                }
            }
            steps {
                	sh 'scp -o StrictHostKeyChecking=no -r dist/* ubuntu@54.200.42.91:/var/www/html'
  				  }
        }
    }
}
