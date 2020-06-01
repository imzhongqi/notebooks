# awk 使用

**Built-in variables (内置变量)**
| name       | description |
| --------   | ----------- |
| FILENAME   | 文件名      |
| FNR        | 当前文件的记录（行）数量 |
| FPAT       | |
| FS         | the input field separator, a space by default.  字段分隔符， 默认是空格 |
| FUNCTAB    | |
| IGNORECASE | 忽略大小写，如果这个值为非零值，则字符串比较和模式匹配都将忽略大小写 |
| NF | the number of fields in the current input record. |
| NR | the total number of input records seen so far. 到目前的总记录数量 |
| OFMT | the output format for numbers, "%.6g", by default. |
| OFS  | the output field separator, a space by default. |
| ORS  | the output record separator, by default a newline |
| PREC | the working precision of arbitrary precision floating-point numbers, 53 by default. 浮点数精度，默认53 |
| SYMTAB | 全局变量数组，delete 对其无效 |  


**Variables, Records and Fields**
awk 里有3个基本的单位，分别是  变量，记录，以及字段
- **Variables**  
awk 的变量是动态的，不需要初始化，就像 php，python 等语言一样，类型有： 浮点数、字符串和数组，数组可以是多维数组

- **Records**  
记录就是类似与 mysql 数据的 row，不过我们可以通过，设置内置变量 `RS` 来重新定义行，默认分隔符就是 '\n'。

- **Fields**  
字段是每个 record，以 `FS` 分隔的值，我们可以重新设置 `FS` 来修改 字段的分隔符。


**Patterns**
```
 BEGIN  
 END  
 BEGINFILE  
 ENDFILE  
 /regular expression/  
 relational expression  
 pattern && pattern  
 pattern || pattern  
 pattern ? pattern : pattern  
 (pattern)  
 ! pattern  
 pattern1, pattern2  
```

**Control Statements**  
```
if (condition) statement [ else statement ]

while (condition) statement

do statement while (condition)

for (expr1; expr2; expr3) statement

for (var in array) statement

break

continue

delete array[index]

delete array

exit [ expression ]

{ statements }

switch (expression) {
  case value|regex : statement
  ...
  [ default: statement ]
}
```


**I/O statements**
- close(file, [,how])
- getline
- getline <file
- getline var
- getline var <file
- print
- printf fmt, expr-list
- printf fmt, expr-list > file
- system(cmd-lie)
- fflush([file])


**Numeric Functions**
- atan2(y, x)
- cos(expr)
- exp(expr)
- int(expr)
- log(expr)
- rand()
- sin(expr)
- sqrt(expr)
- srand([expr])


**String Functions**
- asort(s [, d[, how]])
- asorti(s [,  d[, how]])
- gensub(r, s, h[, t])
- gsub(r, s[, t])
- index(s, t)
- length([s])
- match(s, r[, a])
- patplit(s, a[, r[, seps]])
- split(s, a[, r[, spes]])
- sprintf(fmt, expr-list)
- strtonum(str)
- sub(r, s[, t])
- substr(s, i[, n])
- tolower(str)
- toupper(str)


**Time Functions**
- mktime(datespec)
- strftime([format [, timestamp[, utc-flag]]])
- systime()


**Bit Manipulations Functions**
- and(v1, v2 [, ...])
- compl(val)
- lshift(val, count)
- or(v1, v2 [, ...])
- rshift(val, count)
- xor(v1, v2 [, ...])


**Type Function**
- isarray(x)


**Function define**
```
function myfunc() {
  print  "myfunc called"
}

{
  fn = "myfunc"
  @fn()
}
```


```sh
awk 'function myfn() {print "myfn called"} BEGIN{ fn="myfn"; @fn() }'
```

