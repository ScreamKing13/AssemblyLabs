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
	CaptionOp1 db 'Операція A + B (1)', 0
	CaptionOp2 db 'Операція A + B (2)', 0
	CaptionOp3 db 'Операція A - B', 0
    TextHello db 'Здоровеньки були!', 13, 10, 'Автор: Тутевич Віталій Євгенійович', 13, 10, 'Група: ІО-71', 13, 10, "Номер у списку: 23", 13, 10, "Рік: 2019", 0
	Value_A1 dd 80010001h, 80020001h, 80030001h, 80040001h, 80050001h, 80060001h, 80070001h, 80080001h, 80090001h, 80100001h, 80110001h, 80120001h, 80130001h, 80140001h, 80150001h, 80160001h, 80170001h, 80180001h, 80190001h, 80200001h, 80210001h, 80220001h, 80230001h, 80240001h, 80250001h
	Value_B1 dd 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h

	Value_A2 dd 00000017h, 00000018h, 00000019h, 0000001ah, 0000001bh, 0000001ch, 0000001dh, 0000001eh, 0000001fh, 00000020h, 00000021h, 00000022h, 00000023h, 00000024h, 00000025h, 00000026h, 00000027h, 00000028h, 00000029h, 0000002ah, 0000002bh, 0000002ch, 0000002dh, 0000002eh, 0000002fh
	Value_B2 dd 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h
	
	Value_A3 dd 00000000h, 00000000h, 00000000h, 00000000h, 00000000h, 00000000h, 00000000h, 00000000h, 00000000h, 00000000h
	Value_B3 dd 00000017h, 00000018h, 00000019h, 0000001ah, 0000001bh, 0000001ch, 0000001dh, 0000001eh, 0000001fh, 00000020h
	Result dd 25 dup(0)
	TextBuf dd 100 dup(0)
	TextBufSub dd 100 dup(0)
	ResultSub dd 10 dup(0)

.code

main:
	invoke MessageBoxA, 0, ADDR TextHello, ADDR CaptionHello, 0

	push offset Value_A1
	push offset Value_B1
	push offset Result
	call Add_800_LONGOP

	push offset TextBuf
	push offset Result
	push 800
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR CaptionOp1, MB_ICONINFORMATION

	
	push offset Value_A2
	push offset Value_B2
	push offset Result
	call Add_800_LONGOP

	push offset TextBuf
	push offset Result
	push 800
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR CaptionOp2, MB_ICONINFORMATION

	
	push offset Value_A3
	push offset Value_B3
	push offset ResultSub
	call Sub_320_LONGOP

	push offset TextBufSub
	push offset ResultSub
	push 320
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBufSub, ADDR CaptionOp3, MB_ICONINFORMATION


	invoke ExitProcess, 0
end main
