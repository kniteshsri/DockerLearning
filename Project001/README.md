# Project 001

## Overview

Project 001 is a simple web application that demonstrates the use of HTML, CSS, and JavaScript. This project serves as a learning tool for understanding the basics of web development and containerization using Docker.

## Project Structure

```
Project001
└── Project001
|   ├── src
|       ├── css
|           └── styles.css
|       ├── js
|           └── scripts.js
|       ├── index.html
|       └── Staticfile
|   ├── manifest.yml
|   └── README.md
```

## Getting Started

### Prerequisites

- Docker installed on your machine.

### Building the Docker Image

1. Navigate to the project directory:
   ```
   cd Project001
   ```
2. Build the Docker image:
   ```
   docker build -t project001 .
   ```

### Running the Application

After building the image, you can run the application using:

```
docker run -p 8080:80 project001
```

You can then access the application in your web browser at `http://localhost:8080`.

## File Descriptions

- **src/css/styles.css**: Contains styles for the HTML project.
- **src/js/scripts.js**: Contains JavaScript code for interactivity.
- **src/index.html**: The main HTML document for the project.
- **Dockerfile**: Instructions to build the Docker image.
- **.dockerignore**: Specifies files to ignore when building the Docker image.

## License

This project is licensed under the MIT License.
