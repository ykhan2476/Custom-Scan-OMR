
import sys

def calculate_square(number):
    return number * number

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python example.py <number>")
        sys.exit(1)
    
    input_number = int(sys.argv[1])
    result = calculate_square(input_number)
    print("Square of", input_number, "is", result)