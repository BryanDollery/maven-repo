from adoptopenjdk/openjdk11:alpine as build

# install maven 3.6.3
run apk add curl bash vim unzip git
run curl https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -o mvn.tar.gz
run tar -xzf mvn.tar.gz
run chmod a+rw /apache-maven-3.6.3/bin

env M2_HOME=/apache-maven-3.6.3
env JAVA_HOME=/opt/java/openjdk/
env PATH=$PATH:/$M2_HOME/bin

# Use a random project and maven to to 'seed' the $HOME/.m2/repository folder
run git clone https://github.com/KnowledgeHut-AWS/level3-project.git
workdir cd level3-project
run mvn dependency:go-offline

from adoptopenjdk/openjdk11:alpine
workdir /root

run apk --no-cache add curl bash git sed make vim unzip jq

copy --from=build /root/.m2 /root/.m2/
copy --from=build /apache-maven-3.6.3 /root/maven

env M2_HOME=/root/maven
env JAVA_HOME=/opt/java/openjdk/
env PATH=$PATH:/$M2_HOME/bin

