import datetime
import bisect
import math
import sys

def read_file(filename='stdin.txt'):
	numbers = []
	file = open(filename, "r")
	for line in file:
		numbers.append( int(line, 10) )
	file.close()
	return numbers

def find_frequency(numbers):
	frequencies = []
	current = 0
	freq = math.nan
	while math.isnan(freq):
		if len(frequencies) > 0:
			print("%10d %10d %10d" %(frequencies[0], frequencies[-1], len(frequencies)))
		for number in numbers:
			current += number
			if current in frequencies:
				freq = current
				break
			else:
				bisect.insort(frequencies, current)
	return freq

def main():
	filename = 'stdin.txt'
	if len(sys.argv) == 2:
		filename = str(sys.argv[1])
	numbers = read_file(filename)
	freq = find_frequency(numbers)
	print(freq)

if __name__ == "__main__":
	print(datetime.datetime.now())
	main()
