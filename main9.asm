.586
.model flat, stdcall

option casemap : none ;розрізнювати великі та маленькі букви
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
include \masm32\include\comdlg32.inc

include module.inc
include longop.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib
includelib \masm32\lib\comdlg32.lib

.data
 fileNameAddr dd ? ; буфер для імені файлу
 fileHandle dd 0
 pres dd 0
 CaptionBuf db "Всі значення від 1! до 76! у шістнадцятковій системі числення:", 0
 newline db 13, 10, 0
 Result dd 12 dup(0)
 FactTextBuf dd 100 dup(?)
 symbols db "! = ", 0
 x dd 1
 fd dd 0
 sd dd 0

.code
MySaveFileName proc
 LOCAL ofn : OPENFILENAME
 invoke RtlZeroMemory, ADDR ofn, SIZEOF ofn ; спочатку усі поля обнулюємо
 mov ofn.lStructSize, SIZEOF ofn
 
 invoke GlobalAlloc, GPTR, 1024
 mov fileNameAddr, eax
 
 mov ofn.lpstrFile, eax
 mov ofn.nMaxFile, 1024
 invoke GetSaveFileName, ADDR ofn ; виклик вікна File Save As

 invoke CreateFile, fileNameAddr, GENERIC_WRITE, FILE_SHARE_WRITE, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
 cmp eax, INVALID_HANDLE_VALUE
 je @exit
 mov fileHandle, eax

 invoke lstrlen, ADDR CaptionBuf
 invoke WriteFile, fileHandle, ADDR CaptionBuf, eax, ADDR pres, 0

 mov [Result], 1
	@factorial:
		push offset Result
		push x
		push 12
		call Mul_Nx32_LONGOP

		push offset FactTextBuf
		push offset Result
		push 384
		call StrHex_MY

		invoke lstrlen, ADDR newline
		invoke WriteFile, fileHandle, ADDR newline, eax, ADDR pres, 0

		mov eax, x
		xor edx, edx
		mov ebx, 10
		div bx
		add eax, 48
		add edx, 48
		mov fd, eax
		mov sd, edx

		invoke lstrlen, ADDR fd
		invoke WriteFile, fileHandle, ADDR fd, eax, ADDR pres, 0

		invoke lstrlen, ADDR sd
		invoke WriteFile, fileHandle, ADDR sd, eax, ADDR pres, 0

		invoke lstrlen, ADDR symbols
		invoke WriteFile, fileHandle, ADDR symbols, eax, ADDR pres, 0
		
		invoke lstrlen, ADDR FactTextBuf
		invoke WriteFile, fileHandle, ADDR FactTextBuf, eax, ADDR pres, 0
		

		inc x
		cmp x, 76
		jle @factorial

 jmp @return

 @exit:
	invoke CloseHandle, fileHandle
	invoke GlobalFree, fileNameAddr
	invoke ExitProcess, 0
 
 @return:
	invoke CloseHandle, fileHandle
	invoke GlobalFree, fileNameAddr
	ret
MySaveFileName endp
 
main:
 call MySaveFileName
 cmp eax, 0 ; перевірка: якщо у вікні було натиснуто кнопку Cancel, то EAX=0
 je @exit
 @exit:
	invoke ExitProcess, 0
end main