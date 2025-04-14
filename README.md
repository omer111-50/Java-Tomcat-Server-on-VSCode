# Java Web Application with Tomcat

A simple Java web application using Tomcat with hot reload functionality.

## Prerequisites

1. **Java Development Kit (JDK)**
   - Download OpenJDK from: https://jdk.java.net/17/
   - Extract the downloaded archive:
     ```bash
     # For .tar.gz files (macOS/Linux):
     tar xvf openjdk-17*_bin.tar.gz
     
     # For .zip files (Windows):
     unzip openjdk-17*_bin.zip
     ```
   - Set JAVA_HOME environment variable:
     ```bash
     # macOS/Linux (add to ~/.zshrc or ~/.bash_profile):
     export JAVA_HOME=/path/to/extracted/jdk-17
     export PATH=$JAVA_HOME/bin:$PATH
     
     # Windows (System Properties > Environment Variables):
     # Add JAVA_HOME = C:\path\to\extracted\jdk-17
     # Add %JAVA_HOME%\bin to PATH
     ```
   - Verify installation:
     ```bash
     java -version
     javac -version
     ```

2. **Apache Tomcat 9.0.67**
   - Download from: https://tomcat.apache.org/download-90.cgi
   - Extract to a directory:
     ```bash
     # macOS/Linux:
     tar xvf apache-tomcat-9.0.67.tar.gz
     
     # Windows:
     # Use 7-Zip or Windows Explorer to extract apache-tomcat-9.0.67.zip
     ```
   - Move to desired location (e.g., `/Users/your-username/Downloads/apache-tomcat-9.0.67`)

3. **VS Code Extensions**
   - Java Extension Pack
   - Emerald Walk Run on Save (for hot reload functionality)

## Project Structure

```
.
├── src/
│   ├── main/
│   │   ├── java/           # Java source files
│   │   └── webapp/         # Web application files
│   │       ├── WEB-INF/
│   │       │   ├── lib/    # JAR dependencies
│   │       │   └── web.xml # Web application configuration
│   │       └── *.jsp       # JSP files
├── scripts/
│   ├── macos/              # macOS specific scripts
│   │   ├── build.sh        # Build and deploy script for macOS
│   │   └── manage-tomcat.sh # Tomcat server management script for macOS
│   └── windows/            # Windows specific scripts
│       ├── build.bat       # Build and deploy script for Windows
│       └── manage-tomcat.bat # Tomcat server management script for Windows
├── .vscode/
│   └── settings.json       # VS Code settings
└── .gitattributes          # Git line ending configuration
```

## Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/omer111-50/Java-Tomcat-Server-on-VSCode.git
   cd Java-Tomcat-Server-on-VSCode
   ```

2. **Update Build Path**
   - Open the appropriate build script for your OS:
     - macOS: `scripts/macos/build.sh`
     - Windows: `scripts/windows/build.bat`
   - Update `TOMCAT_DIR` to match your Tomcat installation path
   - For Windows users: Use backslashes (`\`) in the path

3. **Make Scripts Executable (macOS/Linux only)**
   ```bash
   chmod +x scripts/macos/build.sh scripts/macos/manage-tomcat.sh
   ```

4. **Configure VS Code Settings**
   - Open `.vscode/settings.json`
   - Replace `<PLATFORM_BUILD_SCRIPT>` with the appropriate build script path:
     ```json
     // For macOS/Linux:
     "cmd": "./scripts/macos/build.sh",
     
     // For Windows:
     "cmd": ".\\scripts\\windows\\build.bat",
     ```

5. **Line Ending Handling**
   - The repository includes a `.gitattributes` file to handle line endings properly
   - This ensures that:
     - Shell scripts (`.sh`) always use LF line endings
     - Batch scripts (`.bat`) always use CRLF line endings
     - Java, XML, and other source files use LF line endings
   - If you see Git warnings about line endings, you can safely ignore them

## Running the Application

1. **Start Tomcat and Build**
   ```bash
   # macOS/Linux:
   ./scripts/macos/manage-tomcat.sh
   
   # Windows:
   .\scripts\windows\manage-tomcat.bat
   ```
   - The script will check if Tomcat is running
   - If not running, it will start Tomcat and build the application
   - If running, it will ask if you want to stop it

2. **Access the Application**
   - Open your browser and navigate to:
     ```
     http://localhost:8080/myapp/hello
     ```

## Development

- The application supports hot reload through the Emerald Walk Run on Save extension
- Any changes to Java, JSP, XML, or properties files will automatically trigger a rebuild
- No need to restart Tomcat after making changes

## Managing Tomcat

The management scripts provide an easy way to:
- Start Tomcat and build the application
- Stop Tomcat when needed
- Check Tomcat's current status

Simply run:
```bash
# macOS/Linux:
./scripts/macos/manage-tomcat.sh

# Windows:
.\scripts\windows\manage-tomcat.bat
```
And follow the interactive prompts.

## Troubleshooting

1. **Hot Reload Not Working**
   - Ensure Emerald Walk Run on Save extension is installed
   - Check if build script is executable (macOS/Linux)
   - Verify Tomcat is running
   - Check that the correct build script path is set in `.vscode/settings.json`

2. **Build Errors**
   - Check Tomcat logs in `apache-tomcat-9.0.67/logs/catalina.out`
   - Ensure all required JAR files are in `src/main/webapp/WEB-INF/lib/`
   - Verify Java JDK is properly installed and JAVA_HOME is set

3. **Application Not Accessible**
   - Verify Tomcat is running
   - Check if the application is deployed in `apache-tomcat-9.0.67/webapps/myapp`
   - Ensure no other application is using port 8080 