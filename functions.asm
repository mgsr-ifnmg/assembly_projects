section .data

array:
	dd 10, -1, -4, 9, 3, 1, 2

section .text

min:
	mov rdx, 0
	mov rcx, 1
	lea rax, [array + rdx]
.loop:
	add rdx, 4
	lea rbx, [array + rdx]
	cmp rbx, rax
	jg .is_min
.cont:
	inc rcx
	cmp rcx, 6
	jb .loop
	ret
.is_min:
	mov rax, rbx
	jmp .cont

exit:
	mov rax, 0x3c
	xor rdi, rdi
	syscall

global _start
_start:
	call min
	call exit