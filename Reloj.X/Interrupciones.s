	.include "p30F4013.inc"
	.GLOBAL	__INT1Interrupt

	; RELOJ
	.GLOBAL _DHR 
	.GLOBAL _UHR
	.GLOBAL _DMIN 
	.GLOBAL _UMIN 
	.GLOBAL _DSEG 
	.GLOBAL _USEG

; Descripcion: 
; Parametros: Ninguno 
; Return: Nada 
__T1Interrupt:
    PUSH	W0
    
    INC.B	_USEG
    MOV		#10,		W0
    CP.B	_USEG
    BRA		NZ,		FIN_ISR_T1

    CLR.B	_USEG
    INC.B	_DSEG
        
    MOV		#6,		W0
    CP.B	_DSEG
    BRA		NZ,		FIN_ISR_T1
    
    CLR.B	_DSEG
    INC.B	_UMIN
    
    MOV		#10,		W0
    CP.B	_UMIN
    BRA		NZ,		FIN_ISR_T1
    
    CLR.B	_UMIN
    INC.B	_DMIN
    
    MOV		#6,		W0
    CP.B	_DMIN
    BRA		NZ,		FIN_ISR_T1
    
    CLR.B	_DMIN
    INC.B	_UHR
    
    MOV		#2,		W0
    CP.B	_DHR		
    BRA		Z,		CASO_ESPECIAL
    
    MOV		#10,		W0
    CP.B	_UHR
    BRA		NZ,		FIN_ISR_T1

CONT:
    CLR.B	_UHR
    INC.B	_DHR
    
    MOV		#3,		W0
    CP.B	_DHR
    BRA		NZ,		FIN_ISR_T1
    
    CLR.B	_DHR
    INC.B	_USEG
    
FIN_ISR_T1:
    BCLR	IFS0,		#T1IF
    POP		W0
    RETFIE
    
CASO_ESPECIAL:
    MOV		#4,		W0
    CP.B	_UHR
    BRA		NZ,		FIN_ISR_T1
    GOTO	CONT