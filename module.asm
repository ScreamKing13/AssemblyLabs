.586
.model flat, c

.data
x dd 1
n dd 0
num10 db 10
inner dd 0
num7 db 7
minn db 0
spacee db 3

.code

;процедура StrHex_MY записуЇ текст ш≥стнадц€тькового коду
;перший параметр - адреса буфера результату (р€дка символ≥в)
;другий параметр - адреса числа
;трет≥й параметр - розр€дн≥сть числа у б≥тах (маЇ бути кратна 8)

StrHex_MY proc bits:DWORD, src:DWORD, dest:DWORD

	mov ecx, bits ;к≥льк≥сть б≥т≥в числа
	cmp ecx, 0
	jle @exitp
	shr ecx, 3 ;к≥льк≥сть байт≥в числа
	mov esi, src ;адреса числа
	mov ebx, dest ;адреса буфера результату
@cycle:
	mov dl, byte ptr[esi+ecx-1] ;байт числа - це дв≥ hex-цифри

	mov al, dl
	shr al, 4 ;старша цифра
	call HexSymbol_MY
	mov byte ptr[ebx], al

	mov al, dl ;молодша цифра
	call HexSymbol_MY
	mov byte ptr[ebx+1], al

	mov eax, ecx
	cmp eax, 4
	jle @next
	dec eax
	and eax, 3 ;пром≥жок розд≥люЇ групи по в≥с≥м цифр
	cmp al, 0
	jne @next
	mov byte ptr[ebx+2], 32 ;код символа пром≥жку
	inc ebx
	
@next:
	add ebx, 2
	dec ecx
	jnz @cycle
	mov byte ptr[ebx], 0 ;р€док зак≥нчуЇтьс€ нулем
@exitp:
	ret
StrHex_MY endp

;ц€ процедура обчислюЇ код hex-цифри
;параметр - значенн€ AL
;результат -> AL

HexSymbol_MY proc
	and al, 0Fh
	add al, 48 ;так можна т≥льки дл€ цифр 0-9
	cmp al, 58
	jl @exitp
	add al, 7 ;дл€ цифр A,B,C,D,E,F
@exitp:
	ret
HexSymbol_MY endp

Div_Column_LONGOP proc
	xor ebx, ebx                   ;ebx  = 0
	xor ecx, ecx                   ;ecx  = 0
	dec edx                        ;edx -= 1
	cmp byte ptr[esi + edx], 0     ;COMPARE value[esi + edx] AND 0
	jnz @cycleout                  ;IF NOT ZERO FLAG THAN cyclyout
	inc bl                         ;bl += 1

	@cycleout:
		mov ch, byte ptr[esi + edx];ch = value[esi + edx]
		@cycleinner:
			shl cl, 1              ;SHIFT LEFT cl
			shl bh, 1              ;SHIFT LEFT bh
			shl ch, 1              ;SHIFT LEFT ch
			jnc @zero              ;IF NOT CARRIER FLAG THAN zero
			inc bh                 ;bh += 1
			@zero:
			cmp bh, num10          ;COMPARE bh AND num10
			jc @less               ;IF CARRIER FLAG THAN less
			inc cl                 ;cl += 1
			sub bh, num10          ;bh -= 10
			@less:
			inc inner              ;inner += 1
			cmp inner, 8           ;COMPARE inner AND 8
			jnz @cycleinner        
			mov byte ptr[esi + edx], cl
			mov inner, 0
			sub edx, 1
			jnc @cycleout
			ret
Div_Column_LONGOP endp

StrDec proc bits:DWORD, dest:DWORD, src:DWORD
	mov edx, bits	             ;number of symbols
	shr edx, 3				         ;
	mov esi, src		         ;ADRESS input
	mov edi, dest		         ;ADRESS output
	
	mov eax, edx                     ;eax = edx
	shl eax, 2                       ;eax *= 4

	mov cl, byte ptr[esi + edx - 1]  ;cl = value[esi + edx - 1]
	and cl, 128                      ;cl = cl AND 0000000010000000
	cmp cl, 128                      ;COMPARE cl AND 0000000010000000
	jnz @plus
	mov minn, 1                      ;minn = 1
	push edx                         ;edx > stack
	@minus:
		not byte ptr[esi + edx - 1]
		sub edx, 1
		jnz @minus
		inc byte ptr[esi + edx]
		pop edx
	@plus:	
		@cycle:
			push edx
			call Div_Column_LONGOP
			pop edx
			add bh, 48
			mov byte ptr[edi + eax], bh   ;ASCII NUMBER SYMBOL
			dec eax
			cmp bl, 0
			jz @cycle
			dec edx
			jnz @cycle
			cmp minn, 1
			jc @nomin
			mov byte ptr[edi + eax + 1], 45;ASCII MINUS SYMBOL
			dec eax
	@nomin:
		inc eax
		@space:
			mov byte ptr[edi + eax], 32    ;ASCII SPACE SYMBOL
			sub eax, 1
			jnc @space

	ret
StrDec endp
end