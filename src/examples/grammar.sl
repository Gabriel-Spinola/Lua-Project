// Imutable as default
// => (same as return)
// functions call does not need brackets
// := get the returning type

print "Hello, World!"

string immutableVar -> "text"
mut string mutableVar = "Texto"

def sum(int a, int b) -> int:
  int result = a + b

  => result

mut result := sum 2, 3
int immutableResult = sum result, 1

if result >= 2:
  result++

  print "result is greater than 2"


=> "Hi, Mom!"
