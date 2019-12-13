# 二进制转换

```
def encode(s):
    return ' '.join([bin(ord(c)).replace('0b', '') for c in s])

def decode(s):
    return ''.join([chr(i) for i in [int(b, 2) for b in s.split(' ')]])
    
>>>encode('hello')
'1101000 1100101 1101100 1101100 1101111'
>>>decode('1101000 1100101 1101100 1101100 1101111')
'hello'
```
