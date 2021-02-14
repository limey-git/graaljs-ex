#FROM bats-maven
# FROM moderndaypablum/graaljs.mvn.m2:0.0.0
FROM moderndaypablum/maven-3.6.3-openjdk-14-alpine:slimmest AS deps_builder

#COPY settings.xml /usr/share/maven/ref/
COPY pom.xml /tmp/pom.xml
COPY src/ /tmp/src
#RUN mvn -B -f /tmp/pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve
#RUN mvn -B -f /tmp/pom.xml -s /usr/share/maven/ref/settings-docker.xml -DskipTests package exec:exec
#RUN mvn -B -f /tmp/pom.xml -s /usr/share/maven/ref/settings-docker.xml -DskipTests package
RUN mvn -B -f /tmp/pom.xml -s /usr/share/maven/ref/settings-docker.xml -Dmaven.test.failure.ignore=true package

FROM alpine:latest
WORKDIR /root/.m2/repository
COPY --from=deps_builder /usr/share/maven/ref/repository/ .
WORKDIR /
CMD ["ls", "-al", "/root/.m2/repository"]
