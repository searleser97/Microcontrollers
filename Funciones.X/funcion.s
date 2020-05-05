	.include "p30F4013.inc"
	.GLOBAL _funcion1
	.GLOBAL _funcion2
	.GLOBAL _funcion3
	.GLOBAL _funcion4
	.GLOBAL _var	    ;Variable compartida

; Descripcion: Suma 3 a var
; Parametro: Ninguno
; Return: Ninguno
_funcion1:
    PUSH	W2
    MOV		_var,		W2
    ADD		W2,		#3,	    W2
    POP		W2
    RETURN

; Descripcion: Suma 3 + 10
; Parametro: Ninguno
; Return: La suma de 3 + 10 (W0)
_funcion2:
    PUSH	W1
    MOV		#8,		W0
    MOV		#10,		W1
    ADD		W0,		W1,	    W0
    ;El primer registro de la arquitectura es el que siempre se retorna por defecto
    POP W1
    RETURN
    
; Descripcion: suma n1 + n2
; Parametro: n1 y n2
; Return: La suma de n1 + n2 (W0)
_funcion3:
    PUSH	W1
    ADD		W0,		W1,	    W0 ; w0 = n1, w1 = n2
    ;El primer registro de la arquitectura es el que siempre se retorna por defecto
    POP		W1
    RETURN
    
; Descripcion: Recorre una cadena
; Parametro: W0 tiene la dirección del primer elemento de la cadena
; Return: W2 que tiene el tamaño de la cadena
_funcion4:
    PUSH	W1
    PUSH	W2
    
    CLR		W2
CICLO:
    MOV.B	[W0++],		W1
    CP0.B	W1			; Comparando con el caracter NULO de la cadena
    BRA		Z,		FIN
    INC		W2,		W2
    GOTO CICLO
FIN:
    MOV		W2,		W0
    
    POP		W2
    POP		W1  
    RETURN