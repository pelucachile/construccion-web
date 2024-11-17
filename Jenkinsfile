pipeline {
    agent any
    
    tools {
        maven 'maven'
        jdk 'jdk21'
    }
    
    stages {
        stage('Build') {
            steps {
                bat "mvn clean package"  // Correcto para Windows
            }
        }
        
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
            }
        }
    }
}
