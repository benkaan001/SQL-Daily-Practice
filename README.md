# SQL-Daily-Practice
<!-- PRACTICE-BADGES:START -->
![Practice Status](https://github.com/benkaan001/SQL-Daily-Practice/blob/main/.github/badges/practice-status.svg)
![Practice Streak](https://github.com/benkaan001/SQL-Daily-Practice/blob/main/.github/badges/practice-streak.svg)
<!-- PRACTICE-BADGES:END -->

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Introduction

This repository provides a structured environment for daily SQL practice. It combines pre-built datasets with AI-generated practice questions to help users develop and reinforce their SQL skills through consistent practice.

## Key Features

* **Daily Practice Structure**: Organized by date, each practice set includes:
  - A complete dataset
  - Practice questions
  - Optional solution files
* **Local MySQL Environment**: Ready-to-use Docker setup for immediate practice
* **Content Verification**: Automated checks ensure practice content meets quality standards
* **AI-Assisted Generation**: Leverages AI tools to create varied practice scenarios

## Repository Structure

Here's a tree view of the main directories and files in this repository:

```md
SQL-Daily-Practice/
├── LICENSE
├── README.md
├── github
│   └── workflows/
│        └── verify-content.yml
├── datasets
│   ├── daily_practice
│   │   ├── YYYY-MM-DD                          
│   │       ├── dataset.sql
│   │       ├── questions.md
│   │       └── solutions.md
│   └── library_dataset                         
│       ├── library_dataset.sql
│       ├── library_questions.md
│       └── library_solutions.md
├── mysql                                       
│   └── docker-compose.yml
├── scripts                                    
│   ├── _generate_daily_practice.py
│   ├── prompt.txt
│   └── verify_daily_practice_content.py
└── website                                     
    └── content-verification-results.md
```

## Getting Started - Setting up Your MySQL Sandbox

Follow these steps to set up your local MySQL practice environment using Docker Compose:

**Prerequisites:**

*   **Docker Desktop:** You must have Docker Desktop installed on your computer. Download and install it from [Docker Desktop website](https://www.docker.com/products/docker-desktop/). Docker Desktop is free for personal use and simplifies running Docker containers.

**Steps:**

1.  **Fork this Repository:** Click the "Fork" button at the top right of this repository on GitHub to create a copy of this repository in your own GitHub account.
2.  **Clone Your Fork:** Clone your forked repository to your local computer using `git clone <your-fork-repository-url>`.
3.  **Navigate to the `mysql` Directory:** Open your terminal and navigate into the `mysql` folder within your cloned repository:

    ```bash
    cd SQL-Daily-Practice/mysql
    ```

4.  **Create the `.env` file:** Copy the example environment variables file:

    *   **macOS/Linux:** `cp .env.example .env`
    *   **Windows (Command Prompt):** `copy .env.example .env`
    *   **Windows (PowerShell):** `Copy-Item .env.example .env`

5.  **Edit the `.env` file:** Open the `.env` file in a text editor and set your desired MySQL credentials. **Choose strong passwords!**

    ```env
    MYSQL_ROOT_PASSWORD=your_root_password  # Replace with your root password
    MYSQL_USER=practice_user           # Replace with your desired username
    MYSQL_PASSWORD=practice_password     # Replace with your desired password
    ```

    **Important:** **Do not commit the `.env` file to your Git repository!** It contains sensitive database passwords and is already included in `.gitignore` to prevent accidental commits.

6.  **Start MySQL using Docker Compose:** In the `mysql` directory, run the command:

    ```bash
    docker-compose up -d
    ```

    This will download the MySQL Docker image (if needed) and start the MySQL database in the background.

7.  **Verify MySQL is Running:** Check the status of the Docker container:

    ```bash
    docker-compose ps
    ```

    Ensure the `mysql-daily-practice` service shows a `State` of `Up`.

8.  **Connect to MySQL with MySQL Workbench:**

    *   Download and install [MySQL Workbench](https://dev.mysql.com/downloads/workbench/).
    *   Open MySQL Workbench.
    *   Create a new connection:
        *   **Connection Name:** `Daily Practice MySQL` (or any name)
        *   **Connection Method:** `Standard (TCP/IP)`
        *   **Hostname:** `127.0.0.1` or `localhost`
        *   **Port:** `3306`  *(or `3307` if you had to change it due to port conflict - see Troubleshooting section)*
        *   **Username:**  Use the `MYSQL_USER` you set in your `.env` file (e.g., `practice_user`).
        *   **Password:**  Use the `MYSQL_PASSWORD` from your `.env` file.
        *   **Default Schema:** `daily_practice_db`
    *   Click "Test Connection" to verify.
    *   Click "OK" to save the connection.
    *   Double-click your connection to connect.

9.  **Load Datasets:**

    *   **Library Dataset:** Open the `datasets/library_dataset/library_dataset.sql` file in MySQL Workbench and execute the script to create the `library_schema` and load the tables and data.
    *   **Daily Datasets (Future):**  For daily practice, you will load the `dataset.sql` file from the corresponding date folder in `datasets/daily_practice/YYYY-MM-DD/` into MySQL Workbench.

10. **Start Practicing!**  Refer to the `datasets/library_dataset/library_questions.md` file for SQL questions related to the Library Dataset. For daily practice, questions will be in `datasets/daily_practice/YYYY-MM-DD/questions.md`.

## Daily Practice Workflow

1. Load the day's dataset (`dataset.sql`)
2. Review questions in `questions.md`
3. Write and test queries
4. Compare with example solutions (optional)

## SQL Concepts Covered

- Table Creation and Data Manipulation
- Complex Joins and Relationships
- Aggregate Functions
- Subqueries and CTEs
- Window Functions
- Data Analysis Patterns


**GitHub and Development Practices:**

*   **Repository Setup and Organization:**  Creating a well-structured and organized GitHub repository.
*   **Documentation:**  Writing clear and comprehensive `README.md` documentation to explain the project, setup, and usage.
*   **Version Control (Git):**  Utilizing Git for version control, tracking changes, and collaborating (if applicable).
*   **Issue Tracking (Planned):**  Understanding and planning to use GitHub Issues for project management and collaboration.
*   **Open Source Licensing:**  Understanding and applying open-source licenses (MIT License).
*   **Docker and Docker Compose:**  Using Docker Compose to create and manage a containerized MySQL development environment.
*   **Environment Variables and `.env` Files:**  Using `.env` files for secure configuration management and separation of credentials.
*   **Automation:**  GitHub Actions for automation of tasks.

## Schema Organization

In this repository, datasets are organized using **separate MySQL schemas** (databases).

*   **`library_schema`**: Contains the comprehensive `library_dataset`.
*   **`daily_practice_YYYYMMDD_schema`**:  Each daily practice dataset is loaded into its own schema named `daily_practice_YYYYMMDD_schema` (e.g., `daily_practice_20240727_schema`).

**Why Separate Schemas?**

Using separate schemas provides better organization, avoids naming conflicts between datasets, and is a more realistic representation of how databases are often structured in real-world applications. It allows for clear separation and management of different practice datasets within the same MySQL server instance.

When working in MySQL Workbench (or another client), ensure you select the correct schema in your query tab to interact with the desired dataset.

## Troubleshooting

### Connection Issues - "Access Denied" Error

If you encounter "Access denied" errors when trying to connect to the MySQL database from MySQL Workbench (or another client), even after following the setup instructions, it might be due to a **port conflict**.

**Possible Solution (Port Conflict):**

Port `3306` is the default port for MySQL. If another application on your computer is already using port `3306`, your Dockerized MySQL might not be accessible on that port.

**To resolve a potential port conflict:**

1.  **Modify `mysql/docker-compose.yml`:** Change the `ports` mapping to use a different *host* port (e.g., `3307`) while keeping the container port as `3306`.  Edit the `ports` section in `mysql/docker-compose.yml` to look like this:

    ```yaml
    ports:
      - "3307:3306" # Changed host port to 3307
    ```

2.  **Restart Docker Compose:**  In your terminal, in the `mysql` directory, run:

    ```bash
    docker-compose down
    docker-compose up -d
    ```

3.  **Update MySQL Workbench Connection:**  When connecting in MySQL Workbench, use `localhost` or `127.0.0.1` as the hostname, but now use **port `3307`** instead of `3306`. Keep your username and password as configured in your `.env` file.

After making these changes, try testing the connection again in MySQL Workbench. This should resolve the "Access denied" error if it was caused by a port conflict.

If you still encounter issues, please refer to the Docker logs (using `docker-compose logs mysql`) for more detailed error messages and consult online resources or seek help in SQL/Docker communities.

### "Incompatible/nonstandard server version" Warning in MySQL Workbench

You might see a warning message in MySQL Workbench like "Incompatible/nonstandard server version or connection protocol detected (9.1.0)...".  This warning generally **does not affect basic SQL practice**.  It indicates that MySQL Workbench might not be fully tested against the exact MySQL server version being used (in this case, likely a slightly newer version within the 8.x series than officially tested by Workbench).

**Solution:**

For basic to intermediate SQL practice, you can **safely ignore this warning.**  Core SQL functionality will be compatible. If you encounter issues with advanced MySQL Workbench features, you could try pinning to a more specific MySQL 8.0 version in `docker-compose.yml` (e.g., `mysql:8.0.33`), but this is usually not necessary.

## License

MIT License - see the [LICENSE](LICENSE) file for details.


## Automation Features

This repository demonstrates GitHub Actions automation for tracking practice activity:

- **Automated Status Tracking**: Daily checks for SQL practice submissions
- **Visual Status Badges**: Dynamic SVG badges showing current status and streak
- **Activity Reports**: Automatically generated reports of practice patterns
- **Continuous Integration**: GitHub Actions workflow demonstrating CI/CD skills

Check out the [Activity Report](ACTIVITY_REPORT.md) for current statistics.
