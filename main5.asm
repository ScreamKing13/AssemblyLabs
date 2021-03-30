.586
.model flat, stdcall

option casemap : none ;розрізнювати великі та маленькі букви
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc

include module.inc
include longop.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib

.data
	CaptionHello db 'Я програма на асемблері', 0
	TextHello db 'Здоровеньки були!', 13, 10, 'Автор: Тутевич Віталій Євгенійович', 13, 10, 'Група: ІО-71', 13, 10, "Номер у списку: 23", 13, 10, "Рік: 2019", 0
	CaptionTest db "TEST", 0
	CaptionFact1 db "76!", 0
	CaptionFact2 db "76!x76!", 0
	Captionvar1 db "NxN 111...1x111...1", 0
	Captionvar2 db "Nx32 111...1x111...1", 0
	Captionlast db "NxN 111...1x110...0", 0
	
	x dd 76
	var1 dd 12 dup(4294967295)
	var2 dd 1 dup(4294967295)
	var3 dd 12 dup(4294967295)
	var4 dd 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3221225472
	var5 dd 12 dup(4294967295)
	Result dd 12 dup(0)
	testres dd 24 dup(0)
	var1res dd 24 dup(0)
	var2res dd 24 dup(0)

	TextBuf dd 100 dup(?)
	TextBufTest dd 100 dup(?)
	TextBufvar1 dd 100 dup(?)
	TextBufvar2 dd 100 dup(?)
	TextBuflast dd 100 dup(?)


.code

main:
	invoke MessageBoxA, 0, ADDR TextHello, ADDR CaptionHello, 0
	
	mov [Result], 1
	@factorial:
		push offset Result
		push x
		push 12
		call Mul_Nx32_LONGOP

		dec x
		clc
		cmp x, 0
		jne @factorial

	push offset TextBuf
	push offset Result
	push 384
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR TextBuf, ADDR CaptionFact1, 0

	push offset Result
	push offset Result
	push offset testres
	call Mul_NxN_LONGOP

	push offset TextBufTest
	push offset testres
	push 768
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR TextBufTest, ADDR CaptionFact2, 0

	push offset var1
	push offset var1
	push offset var1res
	call Mul_NxN_LONGOP

	push offset TextBufvar1
	push offset var1res
	push 768
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR TextBufvar1, ADDR Captionvar1, 0

	push offset var4
	push offset var5
	push offset var2res
	call Mul_NxN_LONGOP

	push offset TextBuflast
	push offset var2res
	push 768
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR TextBuflast, ADDR Captionlast, 0
	
	mov dword ptr[var3 + 48], 0

	push offset var3
	push var2
	push 13
	call Mul_Nx32_LONGOP

	push offset TextBufvar2
	push offset var3
	push 416
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR TextBufvar2, ADDR Captionvar2, 0

	invoke ExitProcess, 0
end main
