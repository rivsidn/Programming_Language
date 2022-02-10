fibonacci:
%assign i 0
%assign j 1
%rep 100
%if j > 65535
	%exitrep
%endif
	dw j
%assign k j+i
%assign i j
%assign j k
%endrep

fib_number equ ($-fibonacci)/2

