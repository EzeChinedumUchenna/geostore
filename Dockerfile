FROM maven:3.8.1-jdk-11
WORKDIR /app
COPY . .
WORKDIR src
RUN mvn clean install
WORKDIR web/app
EXPOSE 9191
CMD ["mvn", "jetty:run"]
