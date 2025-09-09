import sys

def is_balanced(line):
    count = 0
    for char in line:
        if char == '(':
            count += 1
        elif char == ')':
            count -= 1
            if count < 0:
                return False
    return count == 0

def main():
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        
        result = "yes" if is_balanced(line) else "no"
        print(result)

if __name__ == "__main__":
    main()