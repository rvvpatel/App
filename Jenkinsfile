pipeline {
    agent any    
    stages {
        stage('Install') { 
            steps {
                sh 'npm install' 
            }
        }
        stage('Build for dev') {
            when {
                expression {
                    return GIT_BRANCH == 'origin/master'
                }
            }
            steps {
                sh 'ng build'
            }
        }
    }
}
