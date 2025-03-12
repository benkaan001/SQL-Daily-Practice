import os
import re
from typing import Optional, Any

def verify_daily_practice_content() -> bool:
    """
    Verifies the content of the latest daily SQL practice files.
    Checks for file existence, basic dataset.sql syntax, and questions.md formatting.
    """
    base_dir = 'datasets/daily_practice'
    latest_folder = find_latest_daily_practice_folder(base_dir)

    if not latest_folder:
        print("Error: No daily practice folders found.")
        return False

    folder_path = os.path.join(base_dir, latest_folder)
    dataset_file = os.path.join(folder_path, 'dataset.sql')
    questions_file = os.path.join(folder_path, 'questions.md')
    solutions_file = os.path.join(folder_path, 'solutions.md')

    print(f"Verifying daily practice content in: {folder_path}")

    results = "## Daily Practice Content Verification Results:\n\n"

    # 1. File Existence Check
    results += "### File Existence Check:\n\n"
    all_files_exist = True
    file_checks = [
        (dataset_file, 'dataset.sql'),
        (questions_file, 'questions.md'),
        (solutions_file, 'solutions.md')
    ]
    for path, name in file_checks:
        if os.path.exists(path):
            results += f"- ✅ Found: `{name}`\n"
        else:
            results += f"- ❌ Missing: `{name}`\n"
            all_files_exist = False

    if not all_files_exist:
        results += "\n**Some files are missing. Further checks have been skipped.**\n\n"
        save_results(results, latest_folder)
        return False

    # 2. Basic Syntax Check for dataset.sql
    results += "\n### Basic Syntax Check for dataset.sql:\n\n"
    dataset_syntax_ok = True
    try:
        with open(dataset_file, 'r') as f:
            content = f.read()
            if not re.search(r'CREATE\s+TABLE', content, re.IGNORECASE) or not re.search(r'INSERT\s+INTO', content, re.IGNORECASE):
                results += "- ⚠️ Warning: `dataset.sql` might be missing 'CREATE TABLE' or 'INSERT INTO' statements.\n"
                dataset_syntax_ok = False
            else:
                results += "- ✅ `dataset.sql` contains both 'CREATE TABLE' and 'INSERT INTO' statements.\n"
    except Exception as err:
        results += f"- ❌ Error reading `dataset.sql`: {err}\n"
        dataset_syntax_ok = False

    # 3. Format Check for questions.md
    results += "\n### Format Check for questions.md:\n\n"
    questions_format_ok = True
    try:
        with open(questions_file, 'r') as f:
            content = f.read()
            if "SQL PRACTICE QUESTIONS".lower() not in content.lower():
                results += "- ❌ Error: Missing 'SQL PRACTICE QUESTIONS' marker in `questions.md`.\n"
                questions_format_ok = False
            else:
                results += "- ✅ 'SQL PRACTICE QUESTIONS' marker found in `questions.md`.\n"

            if not re.search(r"Question \d+:", content) or not re.search(r"Your SQL Answer:", content, re.IGNORECASE):
                results += "- ⚠️ Warning: `questions.md` may be missing question headings or 'Your SQL Answer:' blocks.\n"
                questions_format_ok = False
            else:
                results += "- ✅ `questions.md` has question headings and 'Your SQL Answer:' blocks.\n"
    except Exception as err:
        results += f"- ❌ Error reading `questions.md`: {err}\n"
        questions_format_ok = False

    # 4. Optional Syntax Check for solutions.md (if present)
    if os.path.exists(solutions_file):
        results += "\n### Basic Syntax Check for solutions.md (Optional):\n\n"
        try:
            with open(solutions_file, 'r') as f:
                content = f.read()
                sql_blocks = re.findall(r'```sql(.*?)```', content, re.DOTALL | re.IGNORECASE)
                if sql_blocks:
                    results += f"- ✅ Found {len(sql_blocks)} SQL code block(s) in `solutions.md`.\n"
                else:
                    results += "- ⚠️ Warning: No SQL code blocks found in `solutions.md`.\n"
        except Exception as err:
            results += f"- ❌ Error reading `solutions.md`: {err}\n"

    # 5. Overall Status
    results += "\n### Overall Verification Status:\n\n"
    if all_files_exist and dataset_syntax_ok and questions_format_ok:
        results += "- ✅ PASS: Daily practice content verification succeeded.\n\n"
        overall_passed = True
    else:
        results += "- ❌ FAIL: Some verification checks did not pass. Please review the details above.\n\n"
        overall_passed = False

    print("\n--- Daily Practice Content Verification Results ---")
    print(results)

    results_path = os.path.join('website', f'content-verification-results-{latest_folder}.md')
    save_results(results, latest_folder)
    print(f"Verification results saved to: {results_path}")

    return overall_passed


def find_latest_daily_practice_folder(base: str) -> Optional[Any]:
    """
    Returns the latest daily practice folder (based on YYYY-MM-DD format) inside the specified directory.
    """
    try:
        folders = [
            folder for folder in os.listdir(base)
            if os.path.isdir(os.path.join(base, folder)) and re.match(r'\d{4}-\d{2}-\d{2}', folder)
        ]
        return max(folders) if folders else None
    except Exception as err:
        print(f"Error while listing folders in '{base}': {err}")
        return None


def save_results(content: str, date_folder: str) -> None:
    """
    Saves the verification results to a Markdown file in the website directory.
    """
    output_dir = 'website'
    os.makedirs(output_dir, exist_ok=True)
    file_path = os.path.join(output_dir, f'content-verification-results-{date_folder}.md')
    try:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
    except Exception as err:
        print(f"Error saving verification results: {err}")


if __name__ == "__main__":
    if verify_daily_practice_content():
        print("Daily practice content verification PASSED.")
    else:
        print("Daily practice content verification FAILED. See output above for details.")