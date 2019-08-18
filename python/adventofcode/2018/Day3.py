import datetime
import re
from collections import defaultdict

def solve():
  f = open("input.txt","r")
  lines = f.readlines()
  m = defaultdict(int)
  for line in lines:
    d = re.findall(r"\d+",line)
    claim = list(map(int, d))
    for x in range(claim[1], claim[1]+claim[3]):
      for y in range(claim[2], claim[2]+claim[4]):
        m[(x,y)] += 1
  print( "Overlapping fabric: ", sum(1 for k in m if m[k] > 1) )
    

def main():
  print("\n")
  print("----------------------------------------")
  print(datetime.datetime.now())
  solve()
  print("----------------------------------------")
  print("\n")

if __name__ == "__main__":
  main()
