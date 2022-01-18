pipeline {
    agent any
    
    tools {
        terraform 'terraform'
    }
    stages {
        stage ("terraform init") {
            steps {
                sh 'terraform init'
            }
        }
        stage ("terraform fmt") {
            steps {
                sh 'terraform fmt'
            }
        }
        stage ("terraform validate") {
            steps {
                sh 'terraform validate'
            }
        }
        stage ("terrafrom plan") {
            steps {
                 sh 'terraform plan -out terraform.tfplan' 
                 stash name: "terraform-plan", includes: "terraform.tfplan"
                     }
        }
        stage ("terraform apply") {
            steps {
              script {
                def apply = false
                try {
                   sh 'terraform show terraform.tfplan'
                   input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                   apply = true
                    } catch (err) {
                    apply = false
                    currentBuild.result = 'UNSTABLE'
}
                if(apply){
                   unstash "terraform-plan"
                   sh 'terraform apply terraform.tfplan'
}
}
            }
        }
    }
}
