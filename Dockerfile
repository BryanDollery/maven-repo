from adoptopenjdk/openjdk11:alpine as build

run apk add curl bash vim unzip git
run curl https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -o mvn.tar.gz
run tar -xzf mvn.tar.gz

env M2_HOME=/apache-maven-3.6.3
env JAVA_HOME=/opt/java/openjdk/
env PATH=$PATH:/$M2_HOME/bin

run git clone https://github.com/bryandollery/spring-petclinic-rest.git
run cd spring-petclinic-rest && \
    mvn dependency:go-offline

from adoptopenjdk/openjdk11:alpine

run apk --no-cache add curl bash git sed make vim

copy --from=build /root/.m2 /root/.m2/
copy --from=build /apache-maven-3.6.3 /root/maven

env M2_HOME=/root/maven
env JAVA_HOME=/opt/java/openjdk/
env PATH=$PATH:/$M2_HOME/bin

workdir /root
