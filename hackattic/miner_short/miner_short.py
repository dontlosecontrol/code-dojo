import json
import hashlib
import requests

ACCESS_TOKEN = ''

response=requests.get(f"https://hackattic.com/challenges/mini_miner/problem?access_token={ACCESS_TOKEN}")
block = response.json()['block']
difficulty = response.json()['difficulty']


def calculate_hash(block_dict):
    """Calculate SHA256 hash of JSON block with sorted keys and no whitespace"""
    json_str = json.dumps(block_dict, separators=(',', ':'), sort_keys=True)
    return hashlib.sha256(json_str.encode()).hexdigest()


def has_required_zero_bits(hash_hex, required_bits):
    """Check if hash has required number of leading zero bits"""
    hash_bin = bin(int(hash_hex, 16))[2:].zfill(256)  # 256-bit hash
    return hash_bin.startswith('0' * required_bits)


nonce=0
while True:
    block['nonce'] = nonce
    hash_value = calculate_hash(block)
    if has_required_zero_bits(hash_value, difficulty):
        print(f"Found valid nonce: {nonce}")
        break
    nonce += 1


# Submit solution
solution = {"nonce": nonce}
submit_url = f"https://hackattic.com/challenges/mini_miner/solve?access_token={ACCESS_TOKEN}"
submit_response = requests.post(submit_url, json=solution)
print(f"Respnce: {submit_response.json()}")
