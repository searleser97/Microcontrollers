	.include "p30F4013.inc"
	.GLOBAL _funcion1
	.GLOBAL _funcion2
	.GLOBAL _var	    ;Variable compartida

; Descripcion: Suma 3 a var
; Return: Ninguno
_funcion1:
    MOV		_var,		W2
    ADD		W2,		#3,	    W2
    RETURN

; Descripcion: Suma 3 + 10
; Return: La suma de 3 + 10
_funcion2:
    MOV		#8,		W0
    MOV		#10,		W1
    ADD		W0,		W1,	    W0
    ;El primer registro de la arquitectura es el que siempre se retorna por defecto
    RETURN
    


