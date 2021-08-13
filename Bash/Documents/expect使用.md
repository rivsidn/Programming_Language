## 用途

有些脚本执行过程中需要用户依赖于用户输入，`expect` 将要执行的命令和用户输入统一到一个脚本中，此后不需要用户输入便可以执行脚本。



## 脚本生成

脚本通过`autoexpect` 自动生成，生成后的脚本不需要用户输入便可以完成之前需要用户输入的一系列命令。



### 示例脚本

```bash
$ cat ask_more.sh 
#! /bin/bash

echo "input 1 :"
read num
echo "input 2 :"
read num
echo "input 3 :"
read num
echo "input 4 :"
read num
echo "input 5 :"
read num
```

### 脚本生成

```bash
$ autoexpect ./ask_more.sh 
autoexpect started, file is script.exp
input 1 :
1
input 2 :
2
input 3 :
3
input 4 :
4
input 5 :
5
autoexpect done, file is script.exp
```

### 生成的脚本

```bash

$ cat script.exp 
#!/usr/bin/expect -f
set force_conservative 0  ;# set to 1 to force conservative mode even if
			  ;# script wasn't run conservatively originally
if {$force_conservative} {
	set send_slow {1 .1}
	proc send {ignore arg} {
		sleep .1
		exp_send -s -- $arg
	}
}

set timeout -1
spawn ./ask_more.sh
match_max 100000
expect -exact "input 1 :\r
"
send -- "1\r"
expect -exact "1\r
input 2 :\r
"
send -- "2\r"
expect -exact "2\r
input 3 :\r
"
send -- "3\r"
expect -exact "3\r
input 4 :\r
"
send -- "4\r"
expect -exact "4\r
input 5 :\r
"
send -- "5\r"
expect eof
```



## 案例一 自动登陆ssh

```bash
#! /usr/bin/expect

spawn ssh rivsidn@127.0.0.1
expect "rivsidn@127.0.0.1's password: "
send "passwd\r"

interact
```

