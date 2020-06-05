	.include "p30F4013.inc"
	.GLOBAL	__UART1
	.GLOBAL _DATO
	.GLOBAL _DRCV


; Descripcion: Recibe un dato
; Parametros: Ninguno 
; Return: Nada 
__UART1:
    PUSH	W0
    CLR		W0
    MOV		U1RXREG,	W0
    MOV.B	WREG,		_DATO
    BSET	_DRCV,		#0
    BCLR	IFS0,		#U1RXIF
    POP		W0
    RETFIE
   
    
    