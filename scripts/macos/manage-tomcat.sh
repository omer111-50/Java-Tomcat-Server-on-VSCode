#!/bin/sh

# Get the TOMCAT_DIR from build.sh
TOMCAT_DIR=$(grep 'TOMCAT_DIR=' scripts/macos/build.sh | cut -d'"' -f2)
APP_NAME=$(grep 'APP_NAME=' scripts/macos/build.sh | cut -d'"' -f2)

# Function to check if Tomcat is running
is_tomcat_running() {
    if pgrep -f "org.apache.catalina.startup.Bootstrap" > /dev/null; then
        return 0  # Tomcat is running
    else
        return 1  # Tomcat is not running
    fi
}

# Function to start Tomcat and build
start_tomcat() {
    echo "Starting Tomcat server..."
    "$TOMCAT_DIR/bin/startup.sh"
    
    # Wait for Tomcat to start (give it 5 seconds)
    echo "Waiting for Tomcat to start..."
    sleep 5
    
    # Run the build script
    echo "Running build script..."
    ./scripts/macos/build.sh
    
    echo "Tomcat is now running and application is built!"
    echo "You can access your application at: http://localhost:8080/$APP_NAME"
}

# Function to stop Tomcat
stop_tomcat() {
    echo "Stopping Tomcat server..."
    "$TOMCAT_DIR/bin/shutdown.sh"
    
    # Wait for Tomcat to stop (give it 5 seconds)
    sleep 5
    
    # Double check if Tomcat is still running
    if is_tomcat_running; then
        echo "Tomcat is still running. Forcing shutdown..."
        pkill -f "org.apache.catalina.startup.Bootstrap"
    fi
    
    echo "Tomcat has been stopped."
}

# Main script logic
if is_tomcat_running; then
    echo "Tomcat is currently running."
    printf "Do you want to stop Tomcat? (y/n): "
    read answer
    case "$answer" in
        [yY]*)
            stop_tomcat
            ;;
        *)
            echo "Tomcat will continue running."
            ;;
    esac
else
    echo "Tomcat is not running."
    printf "Do you want to start Tomcat and build the application? (y/n): "
    read answer
    case "$answer" in
        [yY]*)
            start_tomcat
            ;;
        *)
            echo "Tomcat will remain stopped."
            ;;
    esac
fi 