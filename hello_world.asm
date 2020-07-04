bits 64							; 64 bits assembly

section .data					; section of data

msg:							; address to store a block of data
	db 'hello, world!', 0xa		; generate data into msg address

section .text					; section of text -> instructions

global _start					; global _start label
_start:							; the execution start here
	mov rax, 0x1				; write 1 into rax -> the id of write syscall (linux)
	mov rdi, 0x1				; write 1 into rdi -> STDOUT file descriptor
	mov rsi, msg				; write the address of msg into tsi
	mov rdx, 0xe				; write the length of message into rdx - 14 bytes
	syscall						; call write(rdi, rsi, rdx)

	mov rax, 0x3c				; write 60 into rax -> the id of exit syscall (linux)
	xor rdi, rdi				; perform a xor bit-to-bit operation into rdi with itself
	syscall						; call exit(rdi)	