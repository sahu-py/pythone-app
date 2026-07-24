pipeline{
  agent{
    label 'docker-node'
  }
  environment{
    Image = "myapp:${BUILD_NUMBER}"
  }
  stages{
    stage('checkout_scm'){
      steps{
        checkout scm
      }
    }
    stage('build'){
      steps{
        sh 'docker build -t $Image .' 
      }
    }
    stage('trivy scan'){
      steps{
        sh '''
            docker pull aquasec/trivy:latest
            docker run --rm \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -v $HOME/.cache:/root/.cache \
             aquasec/trivy image $Image
            '''
      }
    }
    stage('test'){
      steps{
        sh 'docker run --rm $Image echo "running test"'
      }
    }
    stage('deploy'){
      steps{
        sh '''
            docker -rm myapp -f || true
            docker run -d --name myapp -p 8080:8080 $Image
           '''
      }
    }
  }
  post{
    success{
      echo "deployment successfull"
    }
    failure{
      echo "deployment failed"
    }
    always{
      sh ' docker system prune -f '
    }
  }
}
      
      
        
