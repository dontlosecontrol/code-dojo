import base64
import sys

def decode_base64(encoded_string):
    """Decode a Base64-encoded string and return the decoded result."""
    try:
        decoded_bytes = base64.b64decode(encoded_string)
        return decoded_bytes.decode('utf-8')
    except Exception as e:
        print(f"Error decoding: {e}", file=sys.stderr)
        return None

def main():
    try:
        while True:
            line = input().strip()
            if line:
                decoded = decode_base64(line)
                if decoded:
                    print(decoded)
    except EOFError:
        pass

if __name__ == "__main__":
    main()
