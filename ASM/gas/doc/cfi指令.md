

## 示例

### C代码

```c
#include <stdio.h>

int main()
{
	return 0;
}
```

### 汇编

```asm
	.file	"test.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp				# 保存之前栈基地址
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp			# 设置当前栈基地址
	.cfi_def_cfa_register 6
	movl	$0, %eax			# 设置返回值
	popq	%rbp				# 恢复之前的栈基地址
	.cfi_def_cfa 7, 8
	ret							# 返回
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
```



## 附录

### 寄存器表示

| 数字 | 寄存器 |
| ---- | ------ |
| 6    | rbp    |
| 7    | rsp    |

### 缩略语

| 缩写 | 解释                   | 中文翻译   |
| ---- | ---------------------- | ---------- |
| CFI  | Call Frame Information | 调用栈信息 |
| CFA  | Call Frame Address     | 调用栈地址 |

### 参考资料

* [What are CFI directives in Gnu Assembler (GAS) used for?](https://stackoverflow.com/questions/2529185/what-are-cfi-directives-in-gnu-assembler-gas-used-for)
* [DWARF Debugging Information Fromat](http://www.logix.cz/michal/devel/gas-cfi/dwarf-2.0.0.pdf)
* [GAS: Explanation of .cfi_def_cfa_offset](https://stackoverflow.com/questions/7534420/gas-explanation-of-cfi-def-cfa-offset)
* [In assembly code, how .cfi directive works?](https://stackoverflow.com/questions/29527623/in-assembly-code-how-cfi-directive-works)

### TODO

* [Smashing The Stack For Fun And Profit](https://insecure.org/stf/smashstack.html)