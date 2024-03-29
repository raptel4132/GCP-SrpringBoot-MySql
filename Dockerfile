FROM maven:3.3-jdk-8 AS build
LABEL name=petclinic
LABEL version=0.0.1

COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
COPY docker-compose.yml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

FROM openjdk:8
# copy any jar files into the image
COPY --from=build /usr/src/app/target/*.jar /usr/app/petclinic.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/usr/app/petclinic.jar"]
