.586
.model flat, stdcall

option casemap : none ;розрізнювати великі та маленькі букви
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc

include module.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib

.data
	; X = 33
	; Y = 66
	CaptionHello db 'Я програма на асемблері', 0
    TextHello db 'Здоровеньки були!', 13, 10, 'Автор: Тутевич Віталій Євгенійович', 13, 10, 'Група: ІО-71', 13, 10, "Номер у списку: 23", 13, 10, "Рік: 2019", 0
	Caption1 db "Ціле 8-бітове X", 0
	Caption2 db "Ціле 8-бітове -X", 0
	Caption3 db "Ціле 16-бітове X", 0
	Caption4 db "Ціле 16-бітове -X", 0
	Caption5 db "Ціле 32-бітове X", 0
	Caption6 db "Ціле 32-бітове -X", 0
	Caption7 db "Ціле 64-бітове X", 0
	Caption8 db "Ціле 64-бітове -X", 0
	Caption9 db "Дробове 32-бітове X.0", 0
	Caption10 db "Дробове 32-бітове -Y.0", 0
	Caption11 db "Дробове 32-бітове X.X", 0
	Caption12 db "Дробове 64-бітове X.0", 0
	Caption13 db "Дробове 64-бітове -Y.0", 0
	Caption14 db "Дробове 64-бітове X.X", 0
	Caption15 db "Дробове 80-бітове X.0", 0
	Caption16 db "Дробове 80-бітове -Y.0", 0
	Caption17 db "Дробове 80-бітове X.X", 0
	TextBuf db 64 dup(?) 

	; 8-bit
	X db 33
	minus_X db -33

	; 16-bit
	X16 dw 33
	minus_X16 dw -33

	; 32-bit
	X32 dd 33
	minus_X32 dd -33

	; 64-bit
	X64 dq 33
	minus_X64 dq -33

	; 32-bit float
	X0 dd 33.0
	minus_Y0 dd -66.0
	XX dd 33.33

	; 64-bit float
	X0_64 dq 33.0
	minus_Y0_64 dq -66.0
	XX_64 dq 33.33

	; 80-bit float
	X0_80 dt 33.0
	minus_Y0_80 dt -66.0
	XX_80 dt 33.33

.code

main:
	invoke MessageBoxA, 0, ADDR TextHello, ADDR CaptionHello, 0

	push offset TextBuf
	push offset X
	push 8
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption1, MB_ICONINFORMATION

	push offset TextBuf
	push offset minus_X
	push 8
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption2, MB_ICONINFORMATION

	push offset TextBuf
	push offset X16
	push 16
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption3, MB_ICONINFORMATION

	push offset TextBuf
	push offset minus_X16
	push 16
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption4, MB_ICONINFORMATION

	push offset TextBuf
	push offset X32
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption5, MB_ICONINFORMATION

	push offset TextBuf
	push offset minus_X32
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption6, MB_ICONINFORMATION

	push offset TextBuf
	push offset X64
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption7, MB_ICONINFORMATION

	push offset TextBuf
	push offset minus_X64
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption8, MB_ICONINFORMATION

	push offset TextBuf
	push offset X0
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption9, MB_ICONINFORMATION

	push offset TextBuf
	push offset minus_Y0
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption10, MB_ICONINFORMATION

	push offset TextBuf
	push offset XX
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption11, MB_ICONINFORMATION

	push offset TextBuf
	push offset X0_64
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption12, MB_ICONINFORMATION

	push offset TextBuf
	push offset minus_Y0_64
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption13, MB_ICONINFORMATION

	push offset TextBuf
	push offset XX_64
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption14, MB_ICONINFORMATION

	push offset TextBuf
	push offset X0_80
	push 80
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption15, MB_ICONINFORMATION

	push offset TextBuf
	push offset minus_Y0_80
	push 80
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption16, MB_ICONINFORMATION

	push offset TextBuf
	push offset XX_80
	push 80
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption17, MB_ICONINFORMATION
	
	invoke ExitProcess, 0
end main
