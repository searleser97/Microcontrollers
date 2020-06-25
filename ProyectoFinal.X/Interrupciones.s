	.include "p30F4013.inc"
	.GLOBAL	__T3Interrupt
	.GLOBAL __ADCInterrupt
    
__T3Interrupt:
    BTG		LATD,		#LATD3
    BCLR	IFS0,		#T3IF
    RETFIE

; ISR ADC
; Se ejecuta cuando ya tenemos 16 muestras
__ADCInterrupt:
    PUSH	W0
    PUSH	W1
    MOV		#ADCBUF0,	W1
    CLR		W0
    
    REPEAT	#15
    ADD		W0,		[w1++],		W0
    
    LSR		W0,		#4,		W0
    
    MOV.B	WREG,		U1TXREG
    LSR		W0,		#8,		W0
    MOV.B	WREG,		U1TXREG
    
    BCLR	IFS0,		#ADIF
    
    POP		W1
    POP		W0
    RETFIE
    