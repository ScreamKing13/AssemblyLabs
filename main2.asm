.586
.model flat, stdcall

include \masm32\include\kernel32.inc
include \masm32\include\user32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data
	CaptionHello db 'Я програма на асемблері', 0
    TextHello db 'Здоровеньки були!', 13, 10, 'Автор: Тутевич Віталій Євгенійович', 13, 10, 'Група: ІО-71', 13, 10, "Номер у списку: 23", 13, 10, "Рік: 2019", 0
	Captioncp0   db "Виклик cpuid 0", 0
	Captioncp1   db "Виклик cpuid 1", 0
	Captioncp2   db "Виклик cpuid 2", 0
	Captioncp80h db "Виклик cpuid 80000000h", 0
	Captioncp81h db "Виклик cpuid 80000001h", 0
	Captioncp82h db "Виклик cpuid 80000002h", 0
	Captioncp83h db "Виклик cpuid 80000003h", 0
	Captioncp84h db "Виклик cpuid 80000004h", 0
	Captioncp85h db "Виклик cpuid 80000005h", 0
	Captioncp88h db "Виклик cpuid 80000008h", 0
	Textcp0		 db "EAX = xxxxxxxx", 13, 10,
					"EBX = xxxxxxxx", 13, 10,
					"ECX = xxxxxxxx", 13, 10,
					"EDX = xxxxxxxx", 13, 10,
					"Vendor: xxxxxxxxxxxx", 0
	Textcp1		 db "EAX = xxxxxxxx", 13, 10,
					"EBX = xxxxxxxx", 13, 10,
					"ECX = xxxxxxxx", 13, 10,
					"EDX = xxxxxxxx", 0
	Textcp82h    db "EAX = xxxxxxxx", 13, 10,
					"EBX = xxxxxxxx", 13, 10,
					"ECX = xxxxxxxx", 13, 10,
					"EDX = xxxxxxxx", 13, 10,
					"Brand: xxxxxxxxxxxxxxxx", 0
	data		 dd 4 dup(?)

.code
	;ця процедура записує 8 символів HEX коду числа
	;перший параметр - 32-бітове число
	;другий параметр - адреса буфера тексту
	DwordToStrHex proc
		push ebp
		mov ebp,esp
		mov ebx,[ebp+8]		;другий параметр
		mov edx,[ebp+12]	;перший параметр
		xor eax,eax
		mov edi,7
	@next:
		mov al,dl
		and al,0Fh		;виділяємо одну шістнадцяткову цифру
		add ax,48		;так можна тільки для цифр 0-9
		cmp ax,58
		jl @store
		add ax,7		;для цифр A,B,C,D,E,F
	@store:
		mov [ebx+edi],al
		shr edx,4
		dec edi
		cmp edi,0
		jge @next
		pop ebp
		ret 8
	DwordToStrHex endp

	main:
		invoke MessageBoxA, 0, ADDR TextHello, ADDR CaptionHello, 0
		
		; CPUID 0
		mov eax, 0
		cpuid
		mov dword ptr[Textcp0 + 72], ebx
		mov dword ptr[Textcp0 + 76], edx
		mov dword ptr[Textcp0 + 80], ecx
		mov dword ptr[data], eax
		mov dword ptr[data + 4], ebx
		mov dword ptr[data + 8], ecx
		mov dword ptr[data + 12], edx
		push [data]
		push offset [Textcp0 + 6]
		call DwordToStrHex
		push [data + 4]
		push offset [Textcp0 + 22]
		call DwordToStrHex
		push [data + 8]
		push offset [Textcp0 + 38]
		call DwordToStrHex
		push [data + 12]
		push offset [Textcp0 + 54]
		call DwordToStrHex
		invoke MessageBoxA, 0, ADDR Textcp0, ADDR Captioncp0, 0

		; CPUID 1
		mov eax, 1
		cpuid
		mov dword ptr[data], eax
		mov dword ptr[data + 4], ebx
		mov dword ptr[data + 8], ecx
		mov dword ptr[data + 12], edx
		push [data]
		push offset [Textcp1 + 6]
		call DwordToStrHex
		push [data + 4]
		push offset [Textcp1 + 22]
		call DwordToStrHex
		push [data + 8]
		push offset [Textcp1 + 38]
		call DwordToStrHex
		push [data + 12]
		push offset [Textcp1 + 54]
		call DwordToStrHex
		invoke MessageBoxA, 0, ADDR Textcp1, ADDR Captioncp1, 0

		; CPUID 2
		mov eax, 2
		cpuid
		mov dword ptr[data], eax
		mov dword ptr[data + 4], ebx
		mov dword ptr[data + 8], ecx
		mov dword ptr[data + 12], edx
		push [data]
		push offset [Textcp1 + 6]
		call DwordToStrHex
		push [data + 4]
		push offset [Textcp1 + 22]
		call DwordToStrHex
		push [data + 8]
		push offset [Textcp1 + 38]
		call DwordToStrHex
		push [data + 12]
		push offset [Textcp1 + 54]
		call DwordToStrHex
		invoke MessageBoxA, 0, ADDR Textcp1, ADDR Captioncp2, 0

		; CPUID 80000000h
		mov eax, 80000000h
		cpuid
		mov dword ptr[data], eax
		mov dword ptr[data + 4], ebx
		mov dword ptr[data + 8], ecx
		mov dword ptr[data + 12], edx
		push [data]
		push offset [Textcp1 + 6]
		call DwordToStrHex
		push [data + 4]
		push offset [Textcp1 + 22]
		call DwordToStrHex
		push [data + 8]
		push offset [Textcp1 + 38]
		call DwordToStrHex
		push [data + 12]
		push offset [Textcp1 + 54]
		call DwordToStrHex
		invoke MessageBoxA, 0, ADDR Textcp1, ADDR Captioncp80h, 0

		; CPUID 80000001h
		mov eax, 80000001h
		cpuid
		mov dword ptr[data], eax
		mov dword ptr[data + 4], ebx
		mov dword ptr[data + 8], ecx
		mov dword ptr[data + 12], edx
		push [data]
		push offset [Textcp1 + 6]
		call DwordToStrHex
		push [data + 4]
		push offset [Textcp1 + 22]
		call DwordToStrHex
		push [data + 8]
		push offset [Textcp1 + 38]
		call DwordToStrHex
		push [data + 12]
		push offset [Textcp1 + 54]
		call DwordToStrHex
		invoke MessageBoxA, 0, ADDR Textcp1, ADDR Captioncp81h, 0

		; CPUID 80000002h
		mov eax, 80000002h
		cpuid
		mov dword ptr[Textcp82h + 71], eax
		mov dword ptr[Textcp82h + 75], ebx
		mov dword ptr[Textcp82h + 79], ecx
		mov dword ptr[Textcp82h + 83], edx
		mov dword ptr[data], eax
		mov dword ptr[data + 4], ebx
		mov dword ptr[data + 8], ecx
		mov dword ptr[data + 12], edx
		push [data]
		push offset [Textcp82h + 6]
		call DwordToStrHex
		push [data + 4]
		push offset [Textcp82h + 22]
		call DwordToStrHex
		push [data + 8]
		push offset [Textcp82h + 38]
		call DwordToStrHex
		push [data + 12]
		push offset [Textcp82h + 54]
		call DwordToStrHex
		invoke MessageBoxA, 0, ADDR Textcp82h, ADDR Captioncp82h, 0

		; CPUID 80000003h
		mov eax, 80000003h
		cpuid
		mov dword ptr[Textcp82h + 71], eax
		mov dword ptr[Textcp82h + 75], ebx
		mov dword ptr[Textcp82h + 79], ecx
		mov dword ptr[Textcp82h + 83], edx
		mov dword ptr[data], eax
		mov dword ptr[data + 4], ebx
		mov dword ptr[data + 8], ecx
		mov dword ptr[data + 12], edx
		push [data]
		push offset [Textcp82h + 6]
		call DwordToStrHex
		push [data + 4]
		push offset [Textcp82h + 22]
		call DwordToStrHex
		push [data + 8]
		push offset [Textcp82h + 38]
		call DwordToStrHex
		push [data + 12]
		push offset [Textcp82h + 54]
		call DwordToStrHex
		invoke MessageBoxA, 0, ADDR Textcp82h, ADDR Captioncp83h, 0

		; CPUID 80000004h
		mov eax, 80000004h
		cpuid
		mov dword ptr[Textcp82h + 71], eax
		mov dword ptr[Textcp82h + 75], ebx
		mov dword ptr[Textcp82h + 79], ecx
		mov dword ptr[Textcp82h + 83], edx
		mov dword ptr[data], eax
		mov dword ptr[data + 4], ebx
		mov dword ptr[data + 8], ecx
		mov dword ptr[data + 12], edx
		push [data]
		push offset [Textcp82h + 6]
		call DwordToStrHex
		push [data + 4]
		push offset [Textcp82h + 22]
		call DwordToStrHex
		push [data + 8]
		push offset [Textcp82h + 38]
		call DwordToStrHex
		push [data + 12]
		push offset [Textcp82h + 54]
		call DwordToStrHex
		invoke MessageBoxA, 0, ADDR Textcp82h, ADDR Captioncp84h, 0

		; CPUID 80000005h
		mov eax, 80000005h
		cpuid
		mov dword ptr[data], eax
		mov dword ptr[data + 4], ebx
		mov dword ptr[data + 8], ecx
		mov dword ptr[data + 12], edx
		push [data]
		push offset [Textcp1 + 6]
		call DwordToStrHex
		push [data + 4]
		push offset [Textcp1 + 22]
		call DwordToStrHex
		push [data + 8]
		push offset [Textcp1 + 38]
		call DwordToStrHex
		push [data + 12]
		push offset [Textcp1 + 54]
		call DwordToStrHex
		invoke MessageBoxA, 0, ADDR Textcp1, ADDR Captioncp85h, 0

		; CPUID 80000008h
		mov eax, 80000008h
		cpuid
		mov dword ptr[data], eax
		mov dword ptr[data + 4], ebx
		mov dword ptr[data + 8], ecx
		mov dword ptr[data + 12], edx
		push [data]
		push offset [Textcp1 + 6]
		call DwordToStrHex
		push [data + 4]
		push offset [Textcp1 + 22]
		call DwordToStrHex
		push [data + 8]
		push offset [Textcp1 + 38]
		call DwordToStrHex
		push [data + 12]
		push offset [Textcp1 + 54]
		call DwordToStrHex
		invoke MessageBoxA, 0, ADDR Textcp1, ADDR Captioncp88h, 0
		invoke ExitProcess, 0

	end main