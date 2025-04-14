#!/bin/sh

# Environment variables
TOMCAT_DIR="path/to/apache-tomcat-9.0.67"
APP_NAME="myapp"

# Remove the existing myapp directory
rm -rf "$TOMCAT_DIR/webapps/$APP_NAME"

# Create the necessary directories
mkdir -p "$TOMCAT_DIR/webapps/$APP_NAME/WEB-INF/classes"

# Compile the Java classes
javac -cp "$TOMCAT_DIR/lib/servlet-api.jar:src/main/webapp/WEB-INF/lib/*" -d "$TOMCAT_DIR/webapps/$APP_NAME/WEB-INF/classes" src/main/java/*.java

# Copy the compiled classes and resources to the myapp directory
cp -r src/main/webapp/* "$TOMCAT_DIR/webapps/$APP_NAME/"

# Wait for 1 second
sleep 1