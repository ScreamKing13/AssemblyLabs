.686
.xmm
.model flat, c

.code
MyDotProduct_SSE proc result:DWORD, A:DWORD, B:DWORD, N:DWORD ; к-сть подв слів
	mov edx, N
	shr edx, 2
	mov ecx, 0
	mov eax, A
	mov ebx, B
	mov edi, result
	xorps xmm2, xmm2

	@cycle:
		movaps xmm0, [eax + 4*ecx]
		movaps xmm1, [ebx + 4*ecx]
		mulps xmm0, xmm1
		
		addps xmm2, xmm0

		add ecx, 4
		dec edx
		cmp edx, 0
		jne @cycle
		haddps xmm2, xmm2
		haddps xmm2, xmm2
	
	movaps [edi], xmm2
	
	ret

MyDotProduct_SSE endp

end