import sys

def parse_token(token):
    token = token.strip()

    if not token:
        return 0

    if token.startswith('0x') or token.startswith('0X'):
        return int(token, 16)

    if token.startswith('0o') or token.startswith('0O'):
        return int(token, 8)

    if token.startswith('0b') or token.startswith('0B'):
        return int(token, 2)

    if token.isdigit() or (token.startswith('-') and token[1:].isdigit()):
        return int(token)

    if len(token) == 1:
        return ord(token)

    try:
        return int(token)
    except ValueError:
        return sum(ord(c) for c in token)

def main():
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue

        tokens = line.split()
        total = sum(parse_token(token) for token in tokens)
        print(total)

if __name__ == "__main__":
    main()
