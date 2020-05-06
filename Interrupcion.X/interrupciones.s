	.include "p30F4013.inc"
	.GLOBAL	__INT1Interrupt
	.GLOBAL _UMI
	.GLOBAL _CEN
	.GLOBAL _DEC
	.GLOBAL _UNI
	
; Descripcion: Cuando llega una interrupcion, incrementa 
;		el número de interrupciones que han pasado
; Parametros: Ninguno 
; Return: Nada      
__INT1Interrupt:
    PUSH	W0
    INC.B	_UNI
    MOV		#10,		W0
    
    CP.B	_UNI
    BRA		NZ,		FIN
    CLR.B	_UNI
    INC.B	_DEC
    
    CP.B	_DEC
    BRA		NZ,		FIN
    CLR.B	_DEC
    INC.B	_CEN
    
    CP.B	_CEN
    BRA		NZ,		FIN
    CLR.B	_CEN
    INC.B	_UMI
    
    CP.B	_UMI
    BRA		NZ,		FIN
    CLR.B	_UMI

FIN:
    BCLR	IFS1,		#INT1IF
    POP		W0
    RETFIE
    