# Assignment 1
## Overview

This project involves the creation of a Docker-based environment configured to run an Nginx server with PHP 8.3 and MySQL database. The setup includes a multi-stage Dockerfile, Docker Compose for orchestration, and automated workflows for validation, deployment, and backup


## Dockerfile Configuration

The Dockerfile uses a multi-stage build approach with Alpine as the base image. The build is split into two stages: **Test** and **Prod**.

-   **Test Stage**:
     -   Includes diagnostic tools for testing and validation.
-   **Prod Stage**:
     - Excludes diagnostic tools to optimize the production environment

**Nginx Configuration**

The Nginx server is configured to respond to requests on localhost. The root directory is set to match the directory for PHP application files, and the default file for PHP requests is specified.
The command that runs inside the container when it starts is a bash script (start.sh) which includes:

- Command to launch PHP-FPM service, which handles PHP script processing.
- A sleep command to allow PHP-FPM to fully start.
- Command to start the Nginx server in the foreground.
  
**Healthcheck**

A healthcheck is defined that performs an HTTP request and exits with status 1 if the request fails.

![Screenshot 2024-08-01 024851](https://github.com/user-attachments/assets/ef785539-7277-4841-ac4e-3341bececc16)

**PHP Application**

The PHP application file establishes a database connection and performs an SQL query to select names from a table. It can display a greeting with the name from a specified line in the table based on the URL parameter.

## Docker Compose Configuration

The docker-compose.yml file defines three services: **test**, **prod**, and **db**.

-   **Test and Prod Services**:
	-   Built from different stages of the Dockerfile.
	-   Configured to interact with a MySQL database.

-   **DB Service**:
	-   Built with a MySQL image.
	-   Includes a healthcheck to verify if the container is active.
	-   Configured with two volumes: one for database backup and one to initiate the database (create table and insert values).
	-   The test and prod services are set to wait for the db service to start first.

## Vulnerabilities

Trivy vulnerability scanner is used to identify security vulnerabilities in the images.

![Screenshot 2024-08-01 025109](https://github.com/user-attachments/assets/6a47109e-7202-43f6-ab34-74f6e867b654)
![Screenshot 2024-08-01 025128](https://github.com/user-attachments/assets/d451b300-69f9-4985-a193-993b7f17f3a2)
![Screenshot 2024-08-01 025240](https://github.com/user-attachments/assets/df6d170d-5877-4935-b333-673e9ef990b1)


## CI/CD Workflows

<![endif]-->

**Test Workflow:**

**1. Validation job**

Triggered by a pull request in the **Test** environment. It includes:

-  **Checkout Code**: Uses the actions/checkout@v4 action.
-  **Set up Docker Buildx**: Uses the docker/setup-buildx-action@v3 action.
-  **Build and Run Docker Compose for Test**:
	-   Builds and starts the containers.
	-   Validates Nginx configuration.
	-   Validates PHP syntax.
 
![Screenshot 2024-08-01 150433](https://github.com/user-attachments/assets/70b5e481-5901-4464-8024-d481e003be5f)

**2. Deployment Job**

Triggered upon successful validation. It includes:

- **Install SSH Key**: Uses the shimataro/ssh-key-action@v2 action to install the SSH key needed for authentication with the remote server.
-  **Add Known Hosts**: Adds the SSH key of the remote host to the known_hosts file.
-  **Copy Secrets into Local File**: Copies MySQL credentials from GitHub secrets into a local .env file on the runner.
-  **Copy Files with SCP**: Copies all files from the GitHub runner to the remote server using scp.
-  **Make Backup Directory**: Creates a backup directory on the remote server.
-  **Spin Up Containers**: Connects to the remote server to start the Docker containers.
-  **Make Backup**: Uses mysqldump to create a backup of the database and saves it with a timestamped filename.
-  **Copy Backup Files with SCP**: Copies the backup files from the remote server to the GitHub runner.
-  **Upload Database Backup**: Uses actions/upload-artifact@v4 to upload the database backup to GitHub with a retention policy of 7 days.


**Backup Workflow**

The DB Backup workflow, which is scheduled to run daily at midnight. The workflow performs a database backup and maintains a retention policy to manage backup storage.

-  **Make Backup**: Uses mysqldump to create a backup of the database and saves it with a timestamped filename.
-  **Copy backup files to VM**: Uses scp to store the backup files in VM
-  **Upload Database Backup**: Uses actions/upload-artifact@v4 to upload the database backup to GitHub with a retention policy of 7 days.

**Deploy Workflow**

-  **Install SSH Key:** Adds the SSH key needed to authenticate with the remote server securely.
-  **Add Known Hosts:** Updates the known_hosts file to avoid SSH connection issues.
-  **Checkout Code:** Retrieves the latest code from the repository to ensure deployment of the most recent version.
- **Version Management:**
	-   **Update Version:** Runs a script to update the application version.
	-   **Commit Changes:** Configures Git, commits the version update, tags it, and pushes these changes to the repository.
-  **File Management:** Removes the old version file from the remote server and copies the updated version file.



<<<<<<< HEAD

=======
>>>>>>> 9a7a261f84061fb88f754b27a3e96edcf75618e6
