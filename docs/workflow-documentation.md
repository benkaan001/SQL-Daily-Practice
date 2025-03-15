# SQL Practice Activity Tracker Workflow

This document provides a detailed explanation of the `sql_practice_activity_tracker.yml` GitHub Actions workflow found in the `.github/workflows` directory of this repository.

## Overview

The `SQL Practice Activity Tracker` workflow is designed to automate the tracking of daily SQL practice activity. It checks for daily commits, calculates practice streaks, generates badges, and updates the repository with the latest practice status.

## GitHub Actions Fundamentals

### What are GitHub Actions?
GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipeline directly in your GitHub repository.

### Key Concepts
- **Workflow**: A configurable automated process made up of one or more jobs
- **Event**: A specific activity that triggers a workflow (e.g., push, schedule)
- **Job**: A set of steps that execute on the same runner
- **Step**: An individual task that can run commands or actions
- **Action**: A custom application for the GitHub Actions platform that performs a complex but frequently repeated task
- **Runner**: A server that runs your workflows when they're triggered

### Understanding YAML Syntax
The workflow is written in YAML, which uses indentation for structure:
```yaml
key: value        # Simple key-value pair
parent:           # Nested structure
  child: value    # Child element
list:             # List/array
  - item1         # List item
  - item2         # List item
```

## How This Workflow Works

### 1. Scheduling and Triggers
```yaml
on:
  schedule:
    - cron: '0 4 * * *'  # Runs at 4 AM UTC daily, which is 10 PM CST
  workflow_dispatch:       # Manual trigger
```
- The `cron` syntax follows: minute (0-59) | hour (0-23) | day of month (1-31) | month (1-12) | day of week (0-6)
- `workflow_dispatch` allows manual execution through GitHub's UI

### 2. Environment Setup
```yaml
jobs:
  track-practice-activity:
    runs-on: ubuntu-latest
    permissions:
      contents: write
```
- Specifies a Linux environment (`ubuntu-latest`)
- Grants necessary permissions to modify repository contents

### 3. Git Operations
The workflow uses several Git commands to analyze activity:
- `git log --since="1 day ago"`: Checks for today's commits
- `git log --since="30 days ago"`: Retrieves commit history for streak calculation
- `--author`: Filters commits by author
- `--date=short`: Formats dates consistently
- `--pretty=format:"%ad"`: Customizes output format

### 4. Pull Latest Changes
Adds a step to pull the latest changes from the remote repository before pushing any new changes:
```yaml
- name: Pull latest changes
  run: git pull origin main
```

### 5. SVG Badge Generation
The workflow creates dynamic SVG badges:
1. Status Badge: Shows if today's practice is completed
   - Green (completed): #4c1
   - Yellow (pending): #dfb317
2. Streak Badge: Displays consecutive practice days
   - Uses consistent blue (#007ec6) theme

### 6. GitHub Environment Variables
The workflow uses GitHub's built-in variables:
- `${{ github.repository }}`: Current repository name
- `$GITHUB_OUTPUT`: File for sharing data between steps
- `${{ steps.*.outputs.* }}`: Accessing step outputs

### 7. File Operations
The workflow manages several files:
- `.github/badges/`: Directory for SVG badge files
- `README.md`: Repository landing page
- `ACTIVITY_REPORT.md`: Detailed activity summary

### 8. Error Handling
```yaml
git commit -m "..." || echo "No changes to commit"
```
The `||` operator ensures the workflow continues even if there are no changes to commit.

## Workflow File Location

```
.github/workflows/sql_practice_activity_tracker.yml
```

## Triggering Events

The workflow is triggered by the following events:
- **Daily Schedule**: Runs daily at 4 AM UTC, which is 10 PM CST.
- **Manual Trigger**: Can be manually triggered for testing purposes.

```yaml
on:
  schedule:
    - cron: '0 4 * * *'  # Daily at 4 AM UTC, which is 10 PM CST
  workflow_dispatch:  # Manual trigger for testing
```

## Job: track-practice-activity

This job consists of several steps to check the practice activity, generate badges, and update the repository.

### Job Configuration

- **runs-on**: Specifies the runner environment.
- **permissions**: Grants write access to repository contents.

```yaml
jobs:
  track-practice-activity:
    runs-on: ubuntu-latest
    permissions:
      contents: write
```

### Steps

#### 1. Checkout Repository

Checks out the repository and fetches the last 30 days of commit history.

```yaml
- name: Checkout Repository
  uses: actions/checkout@v4
  with:
    fetch-depth: 30  # Get last 30 days of history
```

#### 2. Pull Latest Changes

Pulls the latest changes from the remote repository before making any new changes.

```yaml
- name: Pull latest changes
  run: git pull origin main
```

#### 3. Analyze Practice Activity

Analyzes the practice activity by checking for daily commits, calculating streaks, and generating a mini-report of recent activity.

```yaml
- name: Analyze Practice Activity
  id: activity_analysis
  run: |
    # Get today's date
    TODAY=$(date +"%Y-%m-%d")
    echo "today=$TODAY" >> $GITHUB_OUTPUT
    
    # Check if there are any commits for today
    if git log --since="1 day ago" --author="$(git config --get user.email)" | grep -q ""; then
      echo "status=completed" >> $GITHUB_OUTPUT
      echo "message=✅ Practice completed" >> $GITHUB_OUTPUT
    else
      echo "status=pending" >> $GITHUB_OUTPUT
      echo "message=⚠️ Practice pending" >> $GITHUB_OUTPUT
    fi
    
    # Calculate streak by counting days with commits in the last 30 days
    STREAK_DATA=$(git log --since="30 days ago" --author="$(git config --get user.email)" --date=short --pretty=format:"%ad" | sort | uniq)
    STREAK_COUNT=$(echo "$STREAK_DATA" | wc -l)
    echo "streak=$STREAK_COUNT" >> $GITHUB_OUTPUT
    
    # Get last 7 days activity for a mini report
    LAST_WEEK=$(git log --since="7 days ago" --author="$(git config --get user.email)" --date=short --pretty=format:"%ad" | sort | uniq)
    echo "last_week<<EOF" >> $GITHUB_OUTPUT
    echo "$LAST_WEEK" >> $GITHUB_OUTPUT
    echo "EOF" >> $GITHUB_OUTPUT
```

#### 4. Generate Activity Badge

Creates SVG badges for practice status and streak based on the analysis.

```yaml
- name: Generate Activity Badge
  run: |
    mkdir -p .github/badges
    
    # Create practice status badge
    cat > .github/badges/practice-status.svg << EOF
    <svg xmlns="http://www.w3.org/2000/svg" width="180" height="20">
      <linearGradient id="b" x2="0" y2="100%">
        <stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
        <stop offset="1" stop-opacity=".1"/>
      </linearGradient>
      <mask id="a">
        <rect width="180" height="20" rx="3" fill="#fff"/>
      </mask>
      <g mask="url(#a)">
        <path fill="#555" d="M0 0h103v20H0z"/>
        <path fill="${{ steps.activity_analysis.outputs.status == 'completed' && '4c1' || 'dfb317' }}" d="M103 0h77v20H103z"/>
        <path fill="url(#b)" d="M0 0h180v20H0z"/>
      </g>
      <g fill="#fff" text-anchor="middle" font-family="DejaVu Sans,Verdana,Geneva,sans-serif" font-size="11">
        <text x="51.5" y="15" fill="#010101" fill-opacity=".3">Practice Status</text>
        <text x="51.5" y="14">Practice Status</text>
        <text x="140.5" y="15" fill="#010101" fill-opacity=".3">${{ steps.activity_analysis.outputs.message }}</text>
        <text x="140.5" y="14">${{ steps.activity_analysis.outputs.message }}</text>
      </g>
    </svg>
    EOF
    
    # Create streak badge
    cat > .github/badges/practice-streak.svg << EOF
    <svg xmlns="http://www.w3.org/2000/svg" width="170" height="20">
      <linearGradient id="b" x2="0" y2="100%">
        <stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
        <stop offset="1" stop-opacity=".1"/>
      </linearGradient>
      <mask id="a">
        <rect width="170" height="20" rx="3" fill="#fff"/>
      </mask>
      <g mask="url(#a)">
        <path fill="#555" d="M0 0h120v20H0z"/>
        <path fill="#007ec6" d="M120 0h50v20H120z"/>
        <path fill="url(#b)" d="M0 0h170v20H0z"/>
      </g>
      <g fill="#fff" text-anchor="middle" font-family="DejaVu Sans,Verdana,Geneva,sans-serif" font-size="11">
        <text x="60" y="15" fill="#010101" fill-opacity=".3">Practice Streak</text>
        <text x="60" y="14">Practice Streak</text>
        <text x="144" y="15" fill="#010101" fill-opacity=".3">${{ steps.activity_analysis.outputs.streak }} days</text>
        <text x="144" y="14">${{ steps.activity_analysis.outputs.streak }} days</text>
      </g>
    </svg>
    EOF
```

#### 5. Generate Activity Report

Generates an `ACTIVITY_REPORT.md` file summarizing the practice activity.

```yaml
- name: Generate Activity Report
  run: |
    cat > ACTIVITY_REPORT.md << EOF
    # SQL Practice Activity Report
    
    Last updated: ${{ steps.activity_analysis.outputs.today }}
    
    ## Current Status
    
    ${{ steps.activity_analysis.outputs.message }}
    
    ## Practice Streak
    
    **Current streak:** ${{ steps.activity_analysis.outputs.streak }} days
    
    ## Recent Activity
    
    Days with practice in the last week:
    
    \`\`\`
    ${{ steps.activity_analysis.outputs.last_week }}
    \`\`\`
    
    *This report is automatically generated by GitHub Actions to track daily SQL practice activity.*
    EOF
```

#### 6. Update README with Badges

Updates the `README.md` file to include the badges and an automation features section.

```yaml
- name: Update README with Badges
  run: |
    # Check if README exists
    if [ ! -f README.md ]; then
      echo "# SQL Daily Practice" > README.md
    fi
    
    # Update or add badge section
    if grep -q "<!-- PRACTICE-BADGES:START -->" README.md; then
      # Update existing badges
      sed -i '/<!-- PRACTICE-BADGES:START -->/,/<!-- PRACTICE-BADGES:END -->/c\<!-- PRACTICE-BADGES:START -->\n![Practice Status](https://github.com/${{ github.repository }}/blob/main/.github/badges/practice-status.svg)\n![Practice Streak](https://github.com/${{ github.repository }}/blob/main/.github/badges/practice-streak.svg)\n<!-- PRACTICE-BADGES:END -->' README.md
    else
      # Add badges section
      sed -i '1a <!-- PRACTICE-BADGES:START -->\n![Practice Status](https://github.com/${{ github.repository }}/blob/main/.github/badges/practice-status.svg)\n![Practice Streak](https://github.com/${{ github.repository }}/blob/main/.github/badges/practice-streak.svg)\n<!-- PRACTICE-BADGES:END -->' README.md
    fi
    
    # Add automation section if it doesn't exist
    if ! grep -q "## Automation Features" README.md; then
      cat >> README.md << EOF
    
    ## Automation Features
    
    This repository demonstrates GitHub Actions automation for tracking practice activity:
    
    - **Automated Status Tracking**: Daily checks for SQL practice submissions
    - **Visual Status Badges**: Dynamic SVG badges showing current status and streak
    - **Activity Reports**: Automatically generated reports of practice patterns
    - **Continuous Integration**: GitHub Actions workflow demonstrating CI/CD skills
    
    Check out the [Activity Report](ACTIVITY_REPORT.md) for current statistics.
    EOF
    fi
```

#### 7. Commit and Push Changes

Commits and pushes the changes to the repository.

```yaml
- name: Commit and Push Changes
  run: |
    git config --local user.email "github-actions[bot]@users.noreply.github.com"
    git config --local user.name "github-actions[bot]"
    git add .github/badges/ README.md ACTIVITY_REPORT.md
    git commit -m "Update practice activity status: ${{ steps.activity_analysis.outputs.message }}" || echo "No changes to commit"
    git push
```

## Summary

The `SQL Practice Activity Tracker` workflow automates the process of tracking daily SQL practice by:
- Checking for daily commits.
- Calculating practice streaks.
- Generating badges and activity reports.
- Updating the repository's README with the latest status and streak information.
- Committing and pushing these updates to the repository.

This automation helps maintain consistent SQL practice and provides visual and report-based feedback on progress.

For more details, you can view the workflow file [here](https://github.com/benkaan001/SQL-Daily-Practice/blob/main/.github/workflows/sql_practice_activity_tracker.yml).
