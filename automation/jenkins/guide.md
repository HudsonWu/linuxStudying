# Jenkins

Jenkins is a self-contained, open source automation server which can be used to automate all sorts of tasks related to building, testing, and delivering or deploying software.

## Install

### Run standalone by any machine with a Java Runtime Environment(JRE) installed

1. [Download Jenkins](http://mirrors.jenkins.io/war-stable/latest/jenkins.war)
2. Run `java -jar jenkins.war --httpPort=8080`
3. Browse to http://localhost:8080

### Run Jenkins in Docker

```Jenkinsfile
docker run \
    --rm \
    -u root \
    -p 8080:8080 \
    -v jenkins-data:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$HOME":/home \
    jenkinsci/bluocean
```

## Timeouts, retries and more

There are some powerful steps that "wrap" other steps which can easily solve problems like retrying(retry) steps until successful or exiting if a step takes too long(timeout).

```Jenkinsfile
pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                retry(3) {
                    sh './flakey-deploy.sh'
                }

                timeout(time: 3, unit: 'MINUTES') {
                    sh './health-check.sh'
                }
            }
        }
    }
}
```

We can compose these steps together.
```Jenkinsfile
pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                timeout(time: 3, unit: 'MINUTES') {
                    retry(5) {
                        sh './flakey-deploy.sh'
                    }
                }
            }
        }
    }
}
```

## Finishing up

When the Pipeline has finished executing, you may need to run clean-up steps or perform some actions based on the outcome of the Pipeline. These actions can be performed in the `post` section.

```Jenkinsfile
pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'echo "Fail!"; exit 1'
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example , if the Pipeline was previously failing but is now successful'
        }
    }
}
```

## Environment variables

Environment variables can be set globally, or per stage.

```Jenkinsfile
pipeline {
    agent any
    
    environment {
        DISABLE_AUTH = 'true'
        DB_ENGINE = 'sqlite'
    }

    stages {
        stage('Build') {
            steps {
                sh 'printenv'
            }
        }
    }
}
```

## Recording tests and artifacts

Jenkins can record and aggregate test results so long as your test runner can output test result files. Jenkins typically comes bundled with the junit step, but if your test runner cannot output JUnit-style XML reports, there are additional plugins which process practically any widely-used test report format.

```Jenkinsfile
pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh './gradlew check'
            }
        }
    }
    post {
        always {
            junit 'build/reports/**/*.xml'
        }
    }
}
```

When there are test failures, it is often useful to grab built artifacts from Jenkins for local analysis and investigation. This is made practical by Jenkins’s built-in support for storing "artifacts", files generated during the execution of the Pipeline.

```Jenkinsfile
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh './gradlew build'
            }
        }
        stage('Test') {
            steps {
                sh './gradlew check'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'build/libs/**/*.jar', fingerprint: true
            junit 'build/reports/**/*.xml'
        }
    }
}
```
If more than one parameter is specified in the `archiveArtifacts` step, then each parameter’s name must explicitly be specified in the step code - i.e. `artifacts` for the artifact’s path and file name and fingerprint to choose this option. If you only need to specify the artifacts' path and file name/s, then you can omit the parameter name artifacts - e.g.
```
archiveArtifacts 'build/libs/**/*.jar'
```

## Notifications

There are plenty of ways to send notifications, below are a few snippets demonstrating how to send notifications about a Pipeline to an email.

```Jenkinsfile
post {
    failure {
        mail to: 'team@example.com'
             subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
             body: "Something is wrong with ${env.BUILD_URL}"
    }
}
```

## Deployment

The most basic continuous delivery pipeline will have, at minimum, three stages which should be defined in a Jenkinsfile: Build, Test, and Deploy.

One common pattern is to extend the number of stages to capture additional deployment environments, like "staging" or "production", as shown in the following snippet.

```Jenkinsfile
stage('Deploy - Staging') {
    steps {
        sh './deploy staging'
        sh './run-smoke-tests'
    }
}
stage('Deploy - Production') {
    steps {
        sh './deploy production'
    }
}
```

## Asking for human input to proceed

```Jenkinsfile
pipeline {
    agent any
    atages {
        /* "Build" and "Test" stages omitted */

        stage('Deploy -Staging') {
            steps {
                sh './deploy staging'
                sh './run-smoke-tests'
            }
        }

        stage('Sanity check') {
            steps {
                input "Does the staging environment look ok?"
            }
        }

        stage('Deploy - Production') {
            steps {
                sh './deploy production'
            }
        }
    }
}
```
