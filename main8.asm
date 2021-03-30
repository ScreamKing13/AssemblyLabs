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
	a dd 3 dup(0)
	TEMP dd ?
	
.const
var1 dd 12
var2 dd 13

.code
main:
	fild var2
	fild var1
	fsubp
	fistp TEMP

	fild var1
	mov ecx, TEMP
	fistp dword ptr[a + 4 * ecx]
	invoke ExitProcess, 0
end main
