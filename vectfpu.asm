.586
.model flat, c

.code
MyDotProduct_FPU proc dest:DWORD, A:DWORD, B:DWORD, N:DWORD
	mov eax, A
	mov ebx, B
	mov edi, dest
	mov ecx, N
	dec ecx

	fldz

	@cycle:
		fld dword ptr[eax + 4*ecx]
		fmul dword ptr[ebx + 4*ecx]
		faddp st(1), st(0)
		dec ecx
		cmp ecx, 0
		jge @cycle

	fstp dword ptr[edi]

	ret
MyDotProduct_FPU endp
end