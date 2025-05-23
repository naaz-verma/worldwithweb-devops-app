pipeline {
    agent any

    environment {
        EC2_HOST = "65.0.180.57"
        EC2_USER = "ec2-user"
        PEM_KEY = credentials('ec2-pem-key')  // Upload this in Jenkins
    }

    stages {
        stage('Clone Repo') {
            steps {
                git credentialsId: 'github-token', url: 'https://github.com/naaz-verma/worldwithweb-devops-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t worldwithweb-devops-app .'
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(credentials: ['ec2-ssh']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST '
                        docker rm -f worldwithweb-devops-app || true
                        docker pull ghcr.io/naaz-verma/worldwithweb-devops-app:latest
                        docker run -d -p 8000:8000 --name worldwithweb-devops-app ghcr.io/naaz-verma/worldwithweb-devops-app:latest
                    '
                    """
                }
            }
        }
    }
}
