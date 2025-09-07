import re
import sys

def has_digit(s):
    return any(char.isdigit() for char in s)

def convert_hungarian_to_snake(variable_name):
    first_upper_match = re.search(r'[A-Z]', variable_name)

    if not first_upper_match:
        return variable_name.lower()

    first_upper_index = first_upper_match.start()

    base_name = variable_name

    if first_upper_index > 0:
        prefix = variable_name[:first_upper_index]

        if len(prefix) <= 2 or has_digit(prefix):
            base_name = variable_name[first_upper_index:]
    snake_case_name = re.sub(r'(?<!^)(?=[A-Z])', '_', base_name).lower()
    return snake_case_name

if __name__ == "__main__":
    for line in sys.stdin:
        variable_name = line.strip()
        if variable_name:
            print(convert_hungarian_to_snake(variable_name))
