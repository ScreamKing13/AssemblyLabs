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
	
	vartest dd 30 dup(4030467843)
	
	result1 dd 0
	resultBuf1 dd 100 dup(?)
	resultCaption1 db "0011110000001111", 0

	result2 dd 0
	resultBuf2 dd 100 dup(?)
	resultCaption2 db "01111110000001111000000111100000", 0

	result3 dd 0
	resultBuf3 dd 100 dup(?)
	resultCaption3 db "0001111110000001111", 0

.code

main:
	invoke MessageBoxA, 0, ADDR TextHello, ADDR CaptionHello, 0
	
	push offset vartest
	push 9
	push 16
	call SHR_LONGOP
	mov result1, eax

	push offset resultBuf1
	push offset result1
	push 32
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR resultBuf1, ADDR resultCaption1, 0

	push offset vartest
	push 4
	push 32
	call SHR_LONGOP
	mov result2, eax

	push offset resultBuf2
	push offset result2
	push 32
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR resultBuf2, ADDR resultCaption2, 0

	push offset vartest
	push 19
	push 19
	call SHR_LONGOP
	mov result3, eax

	push offset resultBuf3
	push offset result3
	push 32
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR resultBuf3, ADDR resultCaption3, 0
	
	invoke ExitProcess, 0
end main
