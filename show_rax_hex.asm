bits 64							; 64 bits assembly

section .data					; section of data

symbols:						; address to store a block of data
	db '0123456789abcdef'		; generate data into symbols address

newline:						; address to store a single byte
	db 0xa						; generate a single byte into symbols address	

section .text					; section of text

global _start					; define the global label _start
_start:							; the execution start here
	mov rax, 0xffff				; write 0xffff into rax -> content to show in hexadecimal
	mov rdi, 0x1				; write 1 into rdi -> STDOUT file descriptor
	mov rdx, 0x1				; write into rdx the amount of bytes to show
	mov rcx, 0x40				; write 0x40 into rcx (cycle count)

.loop:							; local label to perform a loop 
	sub rcx, 0x4 				; subtract 0x4 of rcx
	push rax					; save rax value into hardware stack
	sar rax, cl 				; perform a shift arithmetic right between rax and cl
	and rax, 0xf 				; perform a logic and between rax with the mask 0xf
	lea rsi, [symbols + rax]	; write into rsi the content of effective address [symbols + rax] 
	mov rax, 0x1				; write 0x1 into rax - id of write syscall (linux)
	push rcx					; save rcx value into hardware stack
	syscall						; call write(rdi, rsi, rdx)
	pop rcx						; get rcx
	pop rax						; get rax
	test rcx, rcx				; test rcx with itself (logic and is performed) 
	jnz .loop					; jnz(jump if not zero) - jump if rcx is not zero

	mov rax, 0x1				; write 0x1 into rax - id of write syscall (linux)
	mov rsi, newline			; mov a single byte into newline to rsi
	syscall						; call write(rdi, rsi, rdx)

	mov rax, 0x3c				; write 0x3c into rax -> id of exit syscall (linux)
	xor rdi, rdi				; perform a xor bit-to-bit operation into rdi with itself
	syscall						; call exit(rdi)