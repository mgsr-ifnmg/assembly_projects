section .data
path:
	db 'assembly.txt'

content:
	db 'writing something into file', 10

section .text

global _start
_start:
	; create a .txt file
	; creat syscall (const char *pathname, mode_t mode)
	; pathname -> rdi
	; mode -> rsi
	mov rax, 85
	mov rdi, path
	mov rsi, 0777
	syscall
	mov rbx, rax

	; write into file
	; write syscall (int fd, const void *buf, size_t count)
	; fd -> rdi
	; buf -> rsi
	; count -> rdx
	mov rdi, rbx
	mov rsi, content
	mov rdx, 28
	mov rax, 1
	syscall

	; close file
	; close syscall (int fd)
	; fd -> rdi
	mov rax, 3
	syscall

	; exit program
	; exit syscall (int status)
	; status -> rdi
	mov rax, 60
	xor rdi, rdi
	syscall