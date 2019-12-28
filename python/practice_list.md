# PYTHON 3 PRACTICE



## Syntax

**Data structures**:  
 `list`, `stack`, `queue`,  
 `tuple`, `empty-tuple`,  
 `set`, `arithmetics on sets`, `frozenset`,  
 `dictionary`,  
 `bytes-object`, `bytearray`, `memoryview`, 

**Loops**:  
 `while-else`,  
 `for-in-else`,
 `for-in-range`,
 `for-in-zip()`,  
 `loop over dictionary`,
 `loop over list with indices`,

**Misc**:  
 `function`,
 `class`,
 `try-except-finally`,
 `lambda`



## Questions

0. List all keywords in Python
1. What's the difference between tuples and lists?
2. What's a list/set/dict comprehension and how is it written/used?
3. How to delete a list item given its index, given its value?
4. What's the syntax of the eval and exec functions?
5. How to get the type of an object?
6. How do function decorators work and how do you write them?



## Answeres

0. `and`, `as`, `assert`, `break`, `class`, `continue`, `def`, `del`, `elif`, `else`, `except`, `False`, `finally`,
 `for`, `from`, `global`, `if`, `import`, `in`, `is`, `lambda`, `nonlocal`, `None`, `not`, `or`, `pass`, `raise`,
 `return`, `True`, `try`, `while`, `with`, `yield`
1. lists are mutable while tuples are immutable
2. List comprehension: `squares = [x**2 for x in range(10)]`  
   Set comprehension: `a = {x for x in 'abracadabra' if x not in 'abc'}`  
   Dictionary comprehension: `{x: x**2 for x in (2, 4, 6)}`
3. Use del-statement: `del a[0]`  
   Use remove method: `list.remove(element)`
4. `eval(expression, [globals[, locals]])`  
   `exec(object, globals, locals)`
5. `type(obj)`
6. 



## Complete list of `dir(__builtins__)`

ArithmeticError
AssertionError
AttributeError
BaseException
BlockingIOError
BrokenPipeError
BufferError
BytesWarning
ChildProcessError
ConnectionAbortedError
ConnectionError
ConnectionRefusedError
ConnectionResetError
DeprecationWarning
EOFError
Ellipsis
EnvironmentError
Exception
False
FileExistsError
FileNotFoundError
FloatingPointError
FutureWarning
GeneratorExit
IOError
ImportError
ImportWarning
IndentationError
IndexError
InterruptedError
IsADirectoryError
KeyError
KeyboardInterrupt
LookupError
MemoryError
ModuleNotFoundError
NameError
None
NotADirectoryError
NotImplemented
NotImplementedError
OSError
OverflowError
PendingDeprecationWarning
PermissionError
ProcessLookupError
RecursionError
ReferenceError
ResourceWarning
RuntimeError
RuntimeWarning
StopAsyncIteration
StopIteration
SyntaxError
SyntaxWarning
SystemError
SystemExit
TabError
TimeoutError
True
TypeError
UnboundLocalError
UnicodeDecodeError
UnicodeEncodeError
UnicodeError
UnicodeTranslateError
UnicodeWarning
UserWarning
ValueError
Warning
ZeroDivisionError
`__build_class__`
`__debug__`
`__doc__`
`__import__`
`__loader__`
`__name__`
`__package__`
`__spec__`
abs
all
any
ascii
bin
bool
breakpoint
bytearray
bytes
callable
chr
classmethod
compile
complex
copyright
credits
delattr
dict
dir
divmod
enumerate
eval
exec
exit
filter
float
format
frozenset
getattr
globals
hasattr
hash
help
hex
id
input
int
isinstance
issubclass
iter
len
license
list
locals
map
max
memoryview
min
next
object
oct
open
ord
pow
print
property
quit
range
repr
reversed
round
set
setattr
slice
sorted
staticmethod
str
sum
super
tuple
type
vars
zip


