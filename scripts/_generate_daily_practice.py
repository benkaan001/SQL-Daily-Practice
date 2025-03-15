"""
TODO: AI Dataset Generation Automation
Issue #<number> - Complete implementation of:
- Configuration file support
- Multiple SQL dialect support
- Template system
- Error logging
- Query validation
- Unit t
"""

import os
import datetime
import ollama
import re

def generate_sql_dataset_ollama(dataset_theme, model_name="deepseek-r1:8b", prompt_file='prompt.txt') -> str | None:
    """
    Generates SQL dataset ONLY using a local Deepseek-r1:8b model.
    Parses SQL code from the ```sql code block, ignoring SECTION markers.
    Includes prefix removal for "ql" at the beginning.

    Args:
        dataset_theme (str): Dataset theme.
        model_name (str): Deepseek-r1:8b model name.
        prompt_file (str): Path to prompt file.

    Returns:
        str | None: dataset_sql_content or None on error.
    """
    try:
        with open(prompt_file, 'r') as f:
            prompt = f.read()
        prompt = prompt.replace("[E-commerce Online Store]", dataset_theme)

        response = ollama.chat(
            model=model_name,
            messages=[
                {'role': 'system', 'content': 'You are a SQL dataset expert.'},
                {'role': 'user', 'content': prompt},
            ],
        )
        content = response['message']['content']

        # Use regex to extract SQL code block (preserving original formatting)
        pattern = re.compile(r"```sql\s*(.*?)\s*```", re.DOTALL | re.IGNORECASE)
        match = pattern.search(content)
        if match:
            dataset_sql_content = match.group(1)

            # Remove potential accidental "ql" prefix (case insensitive)
            if dataset_sql_content.lower().startswith("ql"):
                dataset_sql_content = dataset_sql_content[len("ql"):].lstrip()

            return dataset_sql_content
        else:
            print("Error: Could not find a valid SQL code block delimited by ```sql and ```")
            print("Full AI Response:\n", content)
            return None

    except Exception as e:
        print(f"Error during Ollama API call: {e}")
        return None

if __name__ == "__main__":
    dataset_theme = "E-commerce Online Store"
    dataset_sql_content = generate_sql_dataset_ollama(dataset_theme)

    if dataset_sql_content:
        today_date = datetime.date.today() + datetime.timedelta(days=30)
        formatted_date = today_date.strftime("%Y-%m-%d")

        scripts_dir_path = os.path.dirname(__file__)
        root_dir_path = os.path.dirname(scripts_dir_path)
        daily_practice_dir = os.path.join(root_dir_path, "datasets", "daily_practice", formatted_date)
        os.makedirs(daily_practice_dir, exist_ok=True)

        dataset_file_path = os.path.join(daily_practice_dir, "dataset.sql")
        with open(dataset_file_path, "w") as f:
            f.write(dataset_sql_content)

        print(f"Successfully generated daily practice dataset for {formatted_date} in: {daily_practice_dir}")
        print(f"Dataset file saved to: {dataset_file_path}")
    else:
        print("Failed to generate daily practice dataset using Ollama.")