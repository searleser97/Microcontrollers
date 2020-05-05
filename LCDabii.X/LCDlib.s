	.include "p30F4013.inc"
	.GLOBAL	_datoLCD
	.GLOBAL	_comandoLCD
	.GLOBAL	_BusyFlag
	.GLOBAL	_iniLCD8bits
	
	.EQU	RS_LCD,		RD0	
	.EQU	RW_LCD,		RD1		
	.EQU	E_LCD,		RD2
	.EQU	BF_LCD,		RB7

; Descripcion: Manda un dato al LCD
; Parametros:  W0 tiene el dato a enviar
; Return:      Ninguno
_datoLCD:
    BSET	PORTD,		#RS_LCD
    NOP
    BCLR	PORTD,		#RW_LCD
    NOP
    BSET	PORTD,		#E_LCD
    NOP
    MOV.B	WREG,		PORTB
    NOP
    BCLR	PORTD,		#E_LCD
    NOP
    RETURN

_comandoLCD:
    BCLR	PORTD,		#RS_LCD
    NOP
    BCLR	PORTD,		#RW_LCD  
    NOP
    BSET	PORTD,		#E_LCD 
    NOP
    MOV.B	WREG,		PORTB
    NOP
    BCLR	PORTD,		#E_LCD
    NOP
    RETURN

_BusyFlag:
    PUSH	W2
    CLR		W2
    
    MOV		#0X00FF,	W1
    NOP
    MOV		TRISB,		W2
    IOR		W1,		W2,		W2
    MOV		W2,		TRISB
    
    BCLR	PORTD,		#RS_LCD
    BSET	PORTD,		#RW_LCD
    NOP
    BSET	PORTD,		#E_LCD
    
 CICLO:
    BTSC	PORTB,		#BF_LCD
    GOTO	CICLO
    
    BCLR	PORTD,		#E_LCD
    BCLR	PORTD,		#RW_LCD
    
    MOV		#0XFF00,	W1    
    AND		W2,		W1,		W2
    MOV		W2,		TRISB
    
    POP		W2
    RETURN

_iniLCD8bits:
    PUSH	W0
    CLR		W0
    
    CALL	_RETARDO15ms
    
    MOV		#0X30,		W0
    CALL	_comandoLCD
    
    CALL	_RETARDO15ms
    
    MOV		#0X30,		W0
    CALL	_comandoLCD
    
    CALL	_RETARDO15ms
    
    MOV		#0X30,		W0
    CALL	_comandoLCD
    
    CALL	_BusyFlag
    MOV		#0X38,		W0
    CALL	_comandoLCD
    
    CALL	_BusyFlag
    MOV		#0X08,		W0
    CALL	_comandoLCD
    
    CALL	_BusyFlag
    MOV		#0X01,		W0
    CALL	_comandoLCD
    
    CALL	_BusyFlag
    MOV		#0X06,		W0
    CALL	_comandoLCD
    
    CALL	_BusyFlag
    MOV		#0X0F,		W0
    CALL	_comandoLCD
    
    POP		W0
    RETURN