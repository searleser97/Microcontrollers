	.include "p30F4013.inc"
	.GLOBAL	__UART1
	.GLOBAL _DATO
	.GLOBAL _DRCV


; Descripcion: Recibe un dato
; Parametros: Ninguno 
; Return: Nada 
__UART1:
    PUSH	W0
    PUSH	W1
    MOV		U1RXREG,	W0
    MOV		W0,		_DATO
    MOV		_DRCV,		W1
    MOV		#1,		W1
    MOV		W1,		_DRCV
    BCLR	IFS0,		#U1RXIF
    POP		W1
    POP		W0
    RETFIE
   
    
    