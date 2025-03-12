# SQL-Daily-Practice

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Introduction

Welcome to my SQL Daily Practice repository! This repository is dedicated to enhancing my SQL skills through consistent, daily practice. My goal is to solve 10-20 SQL queries each day using MySQL, focusing on various SQL concepts and techniques. This repository serves as a workspace for my practice.

To facilitate practice, this repository includes:

*   **A comprehensive "Library Dataset"**:  A pre-built dataset with a set of SQL questions ranging from intermediate to advanced levels.
*   **Daily Practice Datasets (Future):**  A structure for incorporating daily generated datasets and questions to provide continuous, varied practice (currently under development, but structure is in place).
*   **A Ready-to-Use MySQL Sandbox**:  Utilizing Docker Compose for easy setup of a local MySQL workspace, allowing anyone to fork this repository and start practicing immediately.

I leverage AI tools like Copilot for dataset and question generation and MySQL Workbench for query testing and database interaction.

## Repository Structure

Here's a tree view of the main directories and files in this repository:

```md
SQL-Daily-Practice/
├── datasets/
│   ├── daily_practice/
│   │   └── YYYY-MM-DD/  (Example: 2024-07-27/)
│   │       ├── dataset.sql
│   │       ├── questions.md
│   │       └── solutions.sql (optional)
│   │       └── ... (more daily folders)
│   └── library_dataset/
│       ├── library_dataset.sql
│       └── library_questions.md
├── github/
│   └── ... (Future GitHub Actions workflows, etc.)
├── mysql/
│   ├── docker-compose.yml
│   └── .env.example
├── LICENSE
└── README.md
```
**Explanation of Folders:**

*   **`datasets/`**: Contains all SQL datasets used for practice.
    *   **`datasets/daily_practice/`**:  Will contain daily practice datasets, organized by date (YYYY-MM-DD folders). Each daily folder will include:
        *   `dataset.sql`: SQL script to create tables and insert data for the daily practice set.
        *   `questions.md`: Markdown file containing SQL practice questions for the daily dataset.
        *   `solutions.sql` (optional):  For storing example solutions to the daily questions.
    *   **`datasets/library_dataset/`**: Contains the comprehensive "Library Dataset" for more extensive practice.
        *   `library_dataset.sql`: SQL script to create the `library_schema` and populate tables for the library dataset.
        *   `library_questions.md`: Markdown file containing SQL questions for the library dataset.
*   **`github/`**:  Intended for future GitHub-specific configurations, such as GitHub Actions workflows or issue templates (currently empty but reserved for future enhancements).
*   **`mysql/`**: Contains files for setting up the local MySQL sandbox using Docker Compose.
    *   `docker-compose.yml`: Docker Compose configuration file to define and run the MySQL database.
    *   `.env.example`: Example `.env` file showing the environment variables required for MySQL setup (e.g., passwords).
*   **`LICENSE`**: Contains the MIT License for this open-source repository.
*   **`README.md`**:  This file - the main documentation for the repository, providing setup instructions, usage guidelines, and repository overview.


## Repository Features Showcase (GitHub Skills)

This repository is designed to demonstrate my understanding of good GitHub practices and project organization:

*   **Clear and Logical Folder Structure:**  The repository is organized into folders (`datasets`, `mysql`, `github`) for easy navigation and clarity.
*   **Comprehensive `README.md`:** This `README.md` file provides a detailed overview of the repository, setup instructions, daily practice workflow, and showcases my skills.
*   **Issue Tracking (Planned):** I intend to utilize GitHub Issues to track feature requests, dataset/question improvements, and to encourage community contributions and discussions around challenging queries.
*   **Pull Requests (Optional - for Future Contributions):** If I expand this repository further or accept external contributions, Pull Requests will be used for code review and managing changes effectively.
*   **GitHub Actions (Optional - Future Automation):**  I plan to explore GitHub Actions to automate daily dataset generation and potentially other tasks in the future to further enhance the repository.
*   **Forkable and Ready-to-Use:** The repository is designed to be easily forked and used by anyone wanting to practice SQL with a ready-made MySQL environment.
*   **Open Source License (MIT License):**  The repository is licensed under the MIT License, demonstrating my understanding of open-source principles and allowing for free use and modification.

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

My typical daily practice workflow involves:

1.  **Dataset Generation (Future Automation):**  (Currently manual, future automation with GitHub Actions planned) Generate a new SQL dataset and corresponding SQL practice questions.
2.  **Dataset Loading:** Load the daily dataset into my local MySQL sandbox using MySQL Workbench by executing the `dataset.sql` script.
3.  **Solving SQL Questions:** Work through the SQL questions provided in `questions.md`, writing and testing SQL queries in MySQL Workbench against the loaded dataset.
4.  **Review and Refinement:** Review my solutions, optimize queries, and explore alternative approaches.
5.  **Commit to GitHub:** Commit the daily dataset (`dataset.sql`), questions (`questions.md`), and optionally my solutions (`solutions.sql`) to this repository, along with any updates to documentation or repository structure.

## Showcase of Skills

This repository is a practical demonstration of my skills in:

**SQL Skills:**

*   **Database Design and Modeling:**  Understanding of relational database concepts and table design (demonstrated in dataset creation).
*   **Data Definition Language (DDL):**  Proficiency in creating and managing database schemas and tables (`CREATE SCHEMA`, `CREATE TABLE`, `DROP TABLE`).
*   **Data Manipulation Language (DML):**  Strong skills in querying and manipulating data using SQL `SELECT`, `INSERT`, `UPDATE`, `DELETE` statements.
*   **Joins:**  Expertise in using various types of JOINs (INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN) to combine data from multiple tables.
*   **Aggregate Functions:**  Using aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) to summarize and analyze data.
*   **Grouping and Filtering:**  Proficiency in using `GROUP BY` and `HAVING` clauses for grouping data and filtering grouped results.
*   **Subqueries and CTEs (Common Table Expressions):**  Ability to write complex queries using subqueries and CTEs for data analysis and manipulation.
*   **Window Functions (Planned):**  Intention to practice and incorporate window functions for advanced data analysis in future practice sets.
*   **MySQL and SQL Standards:**  Hands-on experience with MySQL database system and adherence to SQL standards.

**GitHub and Development Practices:**

*   **Repository Setup and Organization:**  Creating a well-structured and organized GitHub repository.
*   **Documentation:**  Writing clear and comprehensive `README.md` documentation to explain the project, setup, and usage.
*   **Version Control (Git):**  Utilizing Git for version control, tracking changes, and collaborating (if applicable).
*   **Issue Tracking (Planned):**  Understanding and planning to use GitHub Issues for project management and collaboration.
*   **Open Source Licensing:**  Understanding and applying open-source licenses (MIT License).
*   **Docker and Docker Compose:**  Using Docker Compose to create and manage a containerized MySQL development environment.
*   **Environment Variables and `.env` Files:**  Using `.env` files for secure configuration management and separation of credentials.
*   **Automation (Future):**  Exploring and planning to implement GitHub Actions for automation of tasks.

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

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


**Start practicing SQL and enjoy your journey to mastery!**
