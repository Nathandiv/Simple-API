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
│   └── wrapper                        ← Maven Wrapper files
│       ├── maven-wrapper.jar
│       └── maven-wrapper.properties
├── src
│   └── main
│       └── java
│           └── com.example.simple.Api
│               ├── controller
│               │   └── HelloController.java
│               └── SimpleApiApplication.java        ← Spring Boot entry point .The Heart of Spring Boot
│       └── resources                              ← Configuration, static files, templates
│              └── application.yml              ← App & Actuator config
├── target                              ← **Build output** (generated — **do NOT edit**)
│   ├── classes
│   ├── generated-sources
│   ├── generated-test-sources
│   ├── maven-archiver
│   ├── maven-status
│   ├── surefire-reports
│   ├── test-classes
│   ├── simple-Api-0.0.1-SNAPSHOT.jar             ← **The final executable JAR**
│   └── simple-Api-0.0.1-SNAPSHOT.jar.o
├── .gitattributes
├── .gitignore
├── Dockerfile            ← Docker build instructions
├── HELP.md
├── mvnw
├── mvnw.cmd             ← Maven Wrapper scripts
├── pom.xml              ← Project config & dependencies
└── External Libraries


---

## 3. Step-by-Step Setup

### 3.1 Create Project (Spring Initializr)
1. Go to: [https://start.spring.io](https://start.spring.io)
2. Configure:
   - **Project**: Maven
   - **Language**: Java
   - **Spring Boot**: `3.5.7` (or latest 3.x)
   - **Java**: `21`
   - **Group**: `com.example.sipmle`
   - **Artifact**: `sipmle-Api`
   - **Dependencies**:  
     - `Spring Web`  
     - `Spring Boot Actuator`
3. Click **Generate** → Download & unzip to `~/Desktop/sipmle-Api` (or your preferred directory).

This generates a basic Spring Boot project skeleton with `pom.xml` and source code stubs.

### 3.2 Fix Package Name
The generated project might have a default package like `com.example.sipmleapi`. Update it to match your artifact:

```java
// src/main/java/com/example/sipmle/Api/SipmleApiApplication.java
package com.example.sipmle.Api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SipmleApiApplication {
    public static void main(String[] args) {
        SpringApplication.run(SipmleApiApplication.class, args);
    }
}

    
### 3.1 Create /api/hello Endpoint

// src/main/java/com/example/sipmle/Api/controller/HelloController.java
package com.example.sipmle.Api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class HelloController {
    @GetMapping("/hello")
    public String sayHello() {
        return "Hello!";
    }
}


---

### 3.4 Configure Actuator

Spring Boot Actuator provides production-ready features like health checks and metrics. Configure it in the resources folder.

Understanding the Resources Folder, application.properties, and application.yml
The src/main/resources/ folder is where Spring Boot looks for non-executable resources like configuration files, static assets (e.g., HTML/CSS), and templates. It's bundled into the JAR during build and accessible at runtime without needing file system access.

Spring Boot uses externalized configuration to keep settings (e.g., ports, database URLs) separate from code. The two primary files are:

application.properties: A simple key-value format (like key=value). It's human-readable, easy to edit in any text editor, and great for flat, simple configs. 
Example:

server.port=8080
management.endpoints.web.exposure.include=health,info

application.yml (or application.yaml): YAML format with hierarchical structure using indentation (no quotes needed for most values). It's more readable for nested configs (e.g., objects/arrays) and less error-prone for complex setups. Example:

server:
  port: 8080
management:
  endpoints:
    web:
      exposure:
        include: health,info

Why We Need Them:

Separation of Concerns: Code stays clean; configs can be environment-specific (e.g., application-dev.yml for local, application-prod.yml for production).
Flexibility: Override via command-line (java -jar app.jar --server.port=9090), environment variables, or profiles.
Portability: No hard-coded values; easy to deploy across environments.
When to Use:

Use application.properties for simple projects with few, flat configs.
Use application.yml for complex apps with nested settings (e.g., multiple datasources, security configs). Start with YAML for scalability—it's the modern default in Spring docs.

Spring loads both if present (YAML overrides properties for duplicates). Profiles (e.g., application-active.yml) activate based on spring.profiles.active=active.


Create application.yml for this project:

# src/main/resources/application.yml
server:
  port: 8080

management:
  endpoints:
    web:
      exposure:
        include: health,info
  endpoint:
    health:
      show-details: always

info:
  app:
    name: Simple API
    description: Minimal hello API with health check
    version: 1.0.0


## 3.5 Clean pom.xml – **Remove Unnecessary Dependencies**
The Initializr might add extras like JPA. Edit pom.xml to keep it minimal.

Understanding pom.xml: What It Is and Why We Need It
POM stands for Project Object Model. It's the heart of Maven projects—an XML file (pom.xml) that describes your project's metadata, dependencies, build process, and plugins. Think of it as a "blueprint" or "recipe" for building, testing, and packaging your app.

Why We Need It:

Dependency Management: Declares libraries (e.g., Spring Web) with versions, scopes, and exclusions. Maven downloads them from repositories (e.g., Maven Central) automatically.
Build Standardization: Defines how to compile, test, package (e.g., into JAR/WAR), and run the project. Ensures consistent builds across machines/teams.
Inheritance & Reusability: Uses parents (like Spring Boot's) for shared configs (e.g., default plugins, versions).
Portability: No IDE-specific files needed—Maven runs via CLI, making it CI/CD-friendly (e.g., GitHub Actions).
Without It: You'd manually manage JARs, versions, and builds—error-prone, non-reproducible, and unscalable. Projects without POMs can't use Maven commands like mvn package.
    
 ## Break Down of the POM.XML (pom.xml)

 <?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>  <!-- Maven POM schema version (fixed at 4.0.0 for modern projects). Ensures compatibility. -->

    <!-- Parent POM: Inherits from Spring Boot's parent for pre-configured settings (e.g., dependency versions, plugins). -->
    <parent>
        <groupId>org.springframework.boot</groupId>  <!-- Parent's Maven group ID (like a namespace). -->
        <artifactId>spring-boot-starter-parent</artifactId>  <!-- Parent's artifact ID (the "library" name). -->
        <version>3.5.7</version>  <!-- Exact version of the parent to use. -->
        <relativePath/> <!-- lookup parent from repository -->  <!-- Tells Maven to fetch parent from remote repo if not local. -->
    </parent>

    <!-- Project Coordinates: Unique identifier for your project (like Maven's "package name"). -->
    <groupId>com.example</groupId>  <!-- Your organization's namespace (e.g., reverse domain). -->
    <artifactId>sipmle-Api</artifactId>  <!-- Project name (becomes JAR name). -->
    <version>0.0.1-SNAPSHOT</version>  <!-- Semantic version (SNAPSHOT for dev builds). -->
    <name>sipmle-Api</name>  <!-- Human-readable project name (for docs/reports). -->
    <description>Demo project for Spring Boot</description>  <!-- Brief project summary. -->
    <url/>  <!-- Project homepage URL (optional). -->

    <!-- Licensing: Declares open-source licenses for legal compliance. -->
    <licenses>
        <license/>  <!-- Placeholder for license details (e.g., add Apache 2.0). -->
    </licenses>

    <!-- Properties: Global variables for reuse (e.g., versions to avoid repetition). -->
    <properties>
        <java.version>21</java.version>  <!-- Specifies target Java version for compilation/runtime. -->
    </properties>

    <!-- Dependencies: Lists external libraries your project needs. -->
    <dependencies>
        <dependency>  <!-- One dependency block per library. -->
            <groupId>org.springframework.boot</groupId>  <!-- Library's group ID. -->
            <artifactId>spring-boot-starter-actuator</artifactId>  <!-- Library's artifact ID. -->
            <scope></scope>  <!-- Scope: Where the dep is available (e.g., compile, test, runtime). Empty = compile (default). -->
        </dependency>
        <!-- Add more, e.g., spring-boot-starter-web for REST. -->
    </dependencies>

    <!-- Build Configuration: Customizes compilation, packaging, and plugins. -->
    <build>
        <plugins>  <!-- List of Maven plugins for tasks like compiling or testing. -->
            <plugin>  <!-- One plugin per tool/extension. -->
                <groupId>org.apache.maven.plugins</groupId>  <!-- Plugin's group ID. -->
                <artifactId>maven-compiler-plugin</artifactId>  <!-- Plugin for Java compilation. -->
                <configuration>  <!-- Plugin-specific settings. -->
                    <annotationProcessorPaths>  <!-- Paths for annotation processors (e.g., Lombok). -->
                        <path>  <!-- One path per processor. -->
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </path>
                    </annotationProcessorPaths>
                </configuration>
            </plugin>
        </plugins>
    </build>  <!-- Closing build tag (note: your snippet had a duplicate <build>). -->

</project>

NB: Ways to Specify Java Version in pom.xml:

Properties (Recommended for Spring Boot): <properties><java.version>21</java.version></properties> – Spring Boot auto-configures compiler/release plugins.
Compiler Plugin Directly:

<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.13.0</version>
            <configuration>
                <source>21</source>  <!-- Source compatibility. -->
                <target>21</target>  <!-- Target bytecode version. -->
            </configuration>
        </plugin>
    </plugins>
</build>

Release Flag (Java 9+): Add <release>21</release> in compiler config for source+target in one tag.
Maven Compiler Plugin Version: Ensure plugin version ≥3.6 for Java 9+ support.

**Warning: Never mix `<source>` and `<target>` versions!**

- **`<source>21</source>` + `<target>8</target>`**  
  → **Compile fails** – Java 21 features (records, pattern matching) not allowed in Java 8 bytecode  
  → **Fix:** Set both to `21`

- **`<source>8</source>` + `<target>21</target>`**  
  → **Compiles but may crash at runtime** – old code in new JVM = unsafe  
  → **Fix:** Set both to the same version
  
**Best Practice**: Use `<java.version>21</java.version>` in `<properties>` — Spring Boot configures both correctly.

**What is the `<properties>` tag in `pom.xml`?**  
Sets Java version **once** in one place.

**Spring Boot uses it to auto-set:**
- `<source>` and `<target>` in `maven-compiler-plugin`
- JAR manifest
- Runtime compatibility
OR

 Install Java 
so since the project we building is a java 21 we will do for Java 21

# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-21-jdk -y
java -version  # → openjdk 21.x


# macOS (Homebrew)
brew install openjdk@21
sudo ln -sfn $(brew --prefix openjdk@21)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/


# Windows (Chocolatey)
choco install openjdk --version=21

Remove this if present (unneeded for minimal API for this project): 
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>

3.7 Create Maven Wrapper

Run this in your project terminal (mvn -N wrapper:wrapper)


What is Maven Wrapper and Why Do We Need It?
Maven Wrapper (or mvnw) is a script that embeds Maven in your project. It downloads and uses a specific Maven version (defined in .mvn/wrapper/maven-wrapper.properties) without requiring a global Maven install on the developer's machine.

Why We Need It:

Version Consistency: Teams use different Maven installs (e.g., 3.8 vs. 3.9)—wrapper ensures everyone builds with the same version, avoiding "works on my machine" issues.
Onboarding Ease: New clones don't need to install Maven—just run ./mvnw clean package.
CI/CD Reliability: GitHub Actions/Jenkins use the project's Maven, not the host's.
Portability: No system-wide deps; works in air-gapped environments.
What Happens Without It?

You must install Maven globally (sudo apt install maven or download binary).
Builds fail if versions mismatch (e.g., plugin incompatibilities).
Commands like ./mvnw spring-boot:run become mvn spring-boot:run, but inconsistent across setups.
Slower onboarding: Docs must include "Install Maven first."
The wrapper runs like native Maven but is self-contained. 

## 3.8 Run in Development

In your Project Terminal 
./mvnw spring-boot:run

TEST

 Open other Terminal in your Project and RUN 
 
curl http://localhost:8080/api/hello        # → Hello!
curl http://localhost:8080/actuator/health  # → {"status":"UP"}


## 3.9 Build Portable JAR

### `target/` Folder – What It Is & Why It Matters

**Warning: Never commit `target/` to Git** — it's auto-generated and can be rebuilt anytime.

| Subfolder/File                        | Purpose                                                                 |
|--------------------------------------|-------------------------------------------------------------------------|
| `classes/`                           | Contains compiled `.class` files from your `.java` sources              |
| `generated-sources/`                 | Code auto-generated by tools (e.g., Lombok, MapStruct)                  |
| `maven-status/`                      | Tracks Maven build state (internal use)                                 |
| `simple-Api-0.0.1-SNAPSHOT.jar`      | **The final product** — a **fat JAR** (executable)                      |

#### Why is the JAR file special?

- It’s a **"fat" or "uber" JAR** — includes:
  - Your compiled code
  - All dependencies (Spring, Tomcat, etc.)
  - Embedded web server
- **Runs anywhere with Java 21** → `java -jar app.jar`
- No need for external server (like Tomcat WAR)
- Created by Spring Boot’s `spring-boot-maven-plugin`

In your Project Terminal RUN
./mvnw clean package          → JAR appears in `target/`

→ Output: target/sipmle-Api-0.0.1-SNAPSHOT.jar (executable, fat JAR with all deps).

## 3.10 Run JAR Anywhere

 Open other Terminal RUN 
 
java -jar target/sipmle-Api-0.0.1-SNAPSHOT.jar

 
Test again:

curl http://localhost:8080/api/hello        # → Hello!
curl http://localhost:8080/actuator/health  # → {"status":"UP"}

## 3.11 Proof: Works Outside Project

cp target/sipmle-Api-0.0.1-SNAPSHOT.jar ~/Desktop/my-api.jar
cd ~/Desktop
java -jar my-api.jar

→ Works! No src/, no Maven, no IDE.

4. Dockerize the API

4.1 Create Dockerfile
inside of that dockerfile put this 

# Dockerfile
FROM eclipse-temurin:21-jdk-jammy
COPY target/sipmle-Api-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]

4.2 Build Docker Image
In your Terminal RUN

docker build -t hello-api .

4.3 Run Container
In your Terminal RUN

docker run -p 8080:8080 hello-api


 Stop Container
# If running in foreground
Ctrl + C


5. Common Errors & Fixes

| Error / Result                               | Cause                              | Fix / Note                                   |
|----------------------------------------------|------------------------------------|----------------------------------------------|
| `./mvnw: No such file`                       | Missing wrapper                    | `mvn -N wrapper:wrapper`                     |
| `release 21 not supported`                   | Wrong JDK                          | Install JDK 21                               |
| `Failed to configure DataSource`             | JPA in `pom.xml`                   | Remove `spring-boot-starter-data-jpa`        |
| `404` on `/`                                 | No root mapping                    | Use `/api/hello`                             |
| `openjdk:21-jdk-slim: not found`             | Bad Docker tag                     | Use `eclipse-temurin:21-jdk-jammy`           |
| `TLS handshake timeout`                      | Network issue                      | Retry / restart Docker                       |
| `docker build` fails                         | Missing `.`                        | `docker build -t name .`                     |
| `/actuator/` returns links                   | Actuator discovery endpoint        | Normal – use `/health` or `/info`            |

## Why We Removed `spring-boot-starter-data-jpa`

**JPA** (Java Persistence API) is a standard for mapping Java objects to database tables using **Hibernate**.

`spring-boot-starter-data-jpa` adds:
- Hibernate
- Connection pooling
- `@Entity`, `@Repository`, transactions

It **requires** a database and configuration.

**We removed it because:**
- This is a **simple REST API** – **no database needed**
- Prevents this startup error:  
  `Failed to configure a DataSource: 'url' attribute is not specified and no embedded datasource could be configured.`
- Keeps the JAR **small and fast**
- No unnecessary startup overhead

> Keep it only if you plan to add a database later.

6. Test Commands

curl http://localhost:8080/api/hello
# → Hello!

curl http://localhost:8080/actuator/health
# → {"status":"UP",...}

curl http://localhost:8080/actuator/info
# → {"app":{"name":"Simple API",...}}

7. Full Recap Commands

# 1. Build JAR
./mvnw clean package

# 2. Build Docker image
docker build -t hello-api .

# 3. Run container
docker run -p 8080:8080 hello-api

# 4. Test
curl http://localhost:8080/api/hello
