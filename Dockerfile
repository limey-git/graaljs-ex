FROM moderndaypablum/graaljs.mvn.m2:0.0.0.0 AS graaljs_deps

FROM moderndaypablum/maven-3.6.3-openjdk-14-alpine:slimmest

WORKDIR /root/.m2/repository

COPY --from=graaljs_deps /root/.m2/repository  .

#FROM mcr.microsoft.com/windows/nanoserver:sac2016
#FROM mcr.microsoft.com/windows/nanoserver:10.0.17763.1518-amd64
#FROM mcr.microsoft.com/windows/servercore:10.0.17763.1518-amd64
#FROM mcr.microsoft.com/powershell:windowsservercore-1809
# https://hub.docker.com/r/moderndaypablum/nashorn.vs.graalvm
# docker push moderndaypablum/nashorn.vs.graaljs.alpine:0.0.0

WORKDIR /home/moderndaypablum/development/projects

RUN wget https://github.com/graalvm/graal-js-jdk11-maven-demo/archive/master.zip && jar -xvf master.zip && cd /home/moderndaypablum/development/projects/graal-js-jdk11-maven-demo-master && chmod ugo+wx pom.xml

#COPY jdk11 jdk11/

#ENV JAVA_HOME=C:\\development\\jdk11 MAVEN_HOME=C:\\development\\apache-maven-3.6.3


#COPY apache-maven-3.6.3-bin.zip apache-maven-3.6.3-bin.zip

#RUN %JAVA_HOME%\\bin\\jar -xvf apache-maven-3.6.3-bin.zip
#RUN SET JAVA_HOME=C:\\development\\jdk11
#RUN SET MAVEN_HOME=C:\\development\\apache-maven-3.6.3
#RUN SET PATH=%JAVA_HOME%\\bin;%MAVEN_HOME%\bin;%PATH%

WORKDIR /home/moderndaypablum/development/projects/graal-js-jdk11-maven-demo-master

#COPY target .

#WORKDIR C:\\development\\graalvsnashorn

#COPY mvnw.cmd mvnw.cmd

#COPY pom.xml pom.xml

#ENTRYPOINT ["cmd"]

CMD ["mvn", "package"]