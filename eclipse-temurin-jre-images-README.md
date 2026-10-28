# Eclipse Temurin JRE Runtime Images

## Overview
Certificate-proof runtime-only images for Java applications based on Eclipse Temurin JRE, designed to handle certificate authority changes (DigiCert, ZeroSSL, etc.) without code modifications.

## Available Images

| Directory | Java Version | Base Image | Status |
|-----------|--------------|------------|--------|
| `eclipse-temurin-8-jre` | Java 8 (1.8.0) | eclipse-temurin:8-jre-jammy | ✓ Ready |
| `eclipse-temurin-11-jre` | Java 11 | eclipse-temurin:11-jre-jammy | ✓ Ready |
| `eclipse-temurin-17-jre` | Java 17 (LTS) | eclipse-temurin:17-jre-jammy | ✓ Ready |
| `eclipse-temurin-21-jre` | Java 21 (LTS) | eclipse-temurin:21-jre-jammy | ✓ Ready |

## Features

### Runtime-Only
- **No build tools** (Maven, Gradle removed)
- **Minimal footprint** - only essential runtime dependencies
- **Security-focused** - reduced attack surface

### Certificate Management
- ✓ **144+ trusted CA certificates** in Java truststore
- ✓ **DigiCert support** (current certificates)
- ✓ **ZeroSSL support** (Sectigo/USERTrust chain)
- ✓ **Automatic system cert sync** to Java truststore
- ✓ **Future-proof** for CA changes

### Included Tools
- `curl` - for health checks and downloads
- `bash` - for shell operations
- `ca-certificates` - system certificate management
- `keytool` - Java certificate management

## Building Images

### Via GitHub Actions
1. Go to **Actions** → **Build Docker image**
2. Click **Run workflow**
3. Select the image from dropdown:
   - `eclipse-temurin-8-jre`
   - `eclipse-temurin-11-jre`
   - `eclipse-temurin-17-jre`
   - `eclipse-temurin-21-jre`
4. Click **Run workflow**

Images will be pushed to:
```
artifactory.ssnc.dev/glo-docker-local/glo-docker/eclipse-temurin-{VERSION}-jre:{RUN_ID}
```

### Via Command Line
```bash
# Build locally
podman build -t eclipse-temurin-8-jre:local eclipse-temurin-8-jre/

# Or for any version
podman build -t eclipse-temurin-{VERSION}-jre:local eclipse-temurin-{VERSION}-jre/
```

## Usage

### Pull Image
```bash
podman pull artifactory.ssnc.dev/glo-docker-local/glo-docker/eclipse-temurin-8-jre:{TAG}
```

### Run Application
```bash
# Simple JAR execution
podman run --rm \
  -v /path/to/app.jar:/app/app.jar:ro \
  artifactory.ssnc.dev/glo-docker-local/glo-docker/eclipse-temurin-8-jre:{TAG} \
  java -jar app.jar

# With environment variables
podman run --rm \
  -e JAVA_OPTS="-Xmx2g -Xms512m" \
  -v /path/to/app:/app:ro \
  artifactory.ssnc.dev/glo-docker-local/glo-docker/eclipse-temurin-8-jre:{TAG} \
  java $JAVA_OPTS -jar app.jar
```

### In Dockerfile (Multi-stage Build)
```dockerfile
# Build stage
FROM maven:3.9-jdk-11 AS builder
WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM artifactory.ssnc.dev/glo-docker-local/glo-docker/eclipse-temurin-11-jre:latest
WORKDIR /app
COPY --from=builder /build/target/app.jar .
CMD ["java", "-jar", "app.jar"]
```

## Certificate Validation

### Tested Against
- **Hostname**: atom-bpm-engine-prod.ssnc-corp.cloud
- **Scenario**: DigiCert → ZeroSSL certificate transition
- **Result**: ✓ Passes validation for both certificate types

### Verify Certificates
```bash
# Check trusted CAs in image
podman run --rm {IMAGE} \
  keytool -list -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit | grep trustedCertEntry | wc -l

# Test HTTPS connection
podman run --rm {IMAGE} \
  curl -v https://atom-bpm-engine-prod.ssnc-corp.cloud

# Check specific CA
podman run --rm {IMAGE} \
  keytool -list -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit | grep -i digicert
```

## Certificate Management Details

### How It Works
1. Base image includes comprehensive CA bundle (144+ certificates)
2. During build, `update-ca-certificates` refreshes system certs
3. Custom script imports all system PEM certificates into Java truststore
4. Certificates are automatically trusted by Java applications

### Supported Certificate Authorities
- DigiCert (all variants: Global, Assured ID, High Assurance, TLS G5)
- Sectigo (Public Server Authentication Root R46/E46)
- USERTrust (RSA/ECC Certification Authority)
- Comodo (RSA/ECC Certification Authority)
- And 130+ other globally trusted CAs

### Adding Custom Certificates
If you need to add custom/internal CA certificates:

```dockerfile
FROM artifactory.ssnc.dev/glo-docker-local/glo-docker/eclipse-temurin-11-jre:TAG

# Copy your custom CA certificate
COPY custom-ca.crt /usr/local/share/ca-certificates/

# Import to system and Java truststore
RUN update-ca-certificates && \
    keytool -import -noprompt -trustcacerts \
      -alias custom_ca \
      -file /usr/local/share/ca-certificates/custom-ca.crt \
      -keystore $JAVA_HOME/lib/security/cacerts \
      -storepass changeit
```

## Troubleshooting

### SSL Handshake Failures
```bash
# Enable SSL debugging
java -Djavax.net.debug=ssl -jar app.jar

# Check if cert is in truststore
keytool -list -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit | grep -i {CA_NAME}
```

### Certificate Verification
```bash
# Test with verbose curl
curl -vvv https://your-service.example.com

# Use openssl to check cert chain
echo | openssl s_client -connect your-service.example.com:443 -showcerts
```

## Migration Guide

### From Old Images (with Maven)
1. Use these images only for **runtime** (remove Maven dependencies)
2. Build your application in a separate stage or CI pipeline
3. Copy only the compiled JAR to these runtime images

### From Other JRE Images
These images are drop-in replacements for:
- `openjdk:8-jre`
- `openjdk:11-jre`
- `eclipse-temurin:*-jre` (direct)
- Custom JRE images without cert management

## Version Selection Guide

| Java Version | Use Case | Support Status |
|--------------|----------|----------------|
| Java 8 | Legacy applications | Extended support until 2030 |
| Java 11 | LTS - Production standard | Active LTS |
| Java 17 | LTS - Modern features | Active LTS (Recommended) |
| Java 21 | LTS - Latest features | Active LTS (Newest) |

## Security Considerations

### What's Included
- ✓ Latest security patches from Ubuntu Jammy (22.04)
- ✓ Eclipse Temurin JRE (official OpenJDK build)
- ✓ Minimal attack surface (runtime-only)

### What's NOT Included
- ✗ Build tools (Maven, Gradle)
- ✗ Development tools (git, compilers)
- ✗ Unnecessary utilities

### Best Practices
1. Always use specific tags (not `latest`)
2. Regularly rebuild to get security updates
3. Use multi-stage builds (build ≠ runtime)
4. Run as non-root user in production (add USER directive)
5. Scan images with vulnerability scanners

## Maintenance

### Updating Base Images
Base images are pulled from Artifactory mirror:
```
eclipse-temurin:{VERSION}-jre-jammy
```

To update:
1. Pull latest base image
2. Rebuild via GitHub Actions
3. Test certificate validation
4. Deploy new tags

### Certificate Updates
Certificates are automatically updated via:
- Ubuntu `ca-certificates` package updates
- Eclipse Temurin base image updates

No manual intervention needed for standard CA updates.

## Related Documentation

- [CERT-VALIDATION-REPORT.md](eclipse-temurin-8-jre/CERT-VALIDATION-REPORT.md) - Detailed cert testing results
- [GitHub Workflow](.github/workflows/docker-build.yml) - Automated build configuration

## Support

- **Maintainer**: ganga.bomzan@gmail.com
- **Repository**: glo-docker
- **Artifactory**: artifactory.ssnc.dev/glo-docker-local/glo-docker/

## Changelog

### 2026-04-29
- ✓ Created runtime-only Dockerfiles for JRE 8, 11, 17, 21
- ✓ Removed Maven and build tools
- ✓ Added comprehensive certificate management
- ✓ Validated against DigiCert/ZeroSSL cert changes
- ✓ Added GitHub Actions workflow integration
