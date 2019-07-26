import datetime
import sys
import pdb

def get_checksum(lines):

	def count_chars_in_line(line):
		counts = {}
		for c in line:
			if c in counts:
				counts[c] += 1
			else:
				counts[c] = 1
		return counts

	def has_number_of_chars(counts, num=2):
		for c, n in counts.items():
			if n == num:
				return True
		return False
		
	twos = 0
	threes = 0
	for line in lines:
		counts = count_chars_in_line(line)
		if has_number_of_chars(counts, 2):
			twos += 1
		if has_number_of_chars(counts, 3):
			threes += 1
	return twos*threes

def compare_strings(str1, str2):
	num_diff = 0
	pos = 0
	for i in range(0, len(str1)):
		if str1[i] != str2[i]:
			pos = i
			num_diff += 1
		if num_diff > 1:
			return -1
	if num_diff == 1:
		return pos
	return -1

def compare_lines(lines):
	for i in range(0, len(lines)):
		for j in range(i+1, len(lines)):
			pos = compare_strings(lines[i], lines[j])
			if pos != -1:
				return i,j,pos
	return -1,-1,-1
	
def read_file(filename):
	lines = []
	file = open(filename, "r")
	for line in file:
		lines.append(line)
	file.close()
	return lines

def main():
	filename = 'stdin.txt'
	if len(sys.argv) == 2:
		filename = sys.argv[1]
	lines = read_file(filename)
	
	checksum = get_checksum(lines)
	print("Checksum: " + str(checksum))
	
	i, j, pos = compare_lines(lines)
	print(lines[i])
	print(lines[j])
	print(lines[i][0:pos]+lines[i][pos+1:])
	
	

if __name__ == "__main__":
	print(datetime.datetime.now())
	main()


