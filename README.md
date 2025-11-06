# **sipmle-Api**  
**Simple Spring Boot REST API with `/api/hello` + Actuator + Docker**  
*From Zero to Deploy-Ready JAR & Container*

---

## Project Overview

This project creates a **minimal, production-ready Spring Boot API** that:
- Returns `"Hello!"` at `GET /api/hello`
- Exposes health & info via **Spring Boot Actuator**
- Uses **Java 21**
- Builds a **portable JAR** (runs anywhere with Java)
- Is **fully Dockerized**

Perfect for learning, demos, or as a starter template.

---

## 📂 2. Project Structure
```text
simple-Api/
├── .idea
├── .mvn
│   └── wrapper
│       ├── maven-wrapper.jar
│       └── maven-wrapper.properties
├── src
│   └── main
│       └── java
│           └── com.example.simple.Api
│               ├── controller
│               │   └── HelloController.java
│               └── SimpleApiApplication.java
│       └── resources
├── target
│   ├── classes
│   ├── generated-sources
│   ├── generated-test-sources
│   ├── maven-archiver
│   ├── maven-status
│   ├── surefire-reports
│   ├── test-classes
│   ├── simple-Api-0.0.1-SNAPSHOT.jar
│   └── simple-Api-0.0.1-SNAPSHOT.jar.o
├── .gitattributes
├── .gitignore
├── Dockerfile
├── HELP.md
├── mvnw
├── mvnw.cmd
├── pom.xml
└── External Libraries

    
