	.include "p30F4013.inc"
	.GLOBAL	_datoLCD
	.GLOBAL	_comandoLCD
	.GLOBAL	_BusyFlag
	.GLOBAL	_iniLCD8bits
	.GLOBAL _printLCD
	
	.EQU	RS_LCD,		RD0	
	.EQU	RW_LCD,		RD1		
	.EQU	E_LCD,		RD2
	.EQU	BF_LCD,		RB7
	
; Descripcion: Imprime una cadena en el LCD
; Parametros:  Cadena, W0 tiene la dirección
;	       de la cadena
; Return:      Ninguno
_printLCD:
    PUSH	W0
    PUSH	W1
    
    MOV		W0,		W1
    CLR		W0

LEER_CARACTER:
    MOV.B	[W1++],		W0	    ;W0 = [W1]    
    CP0.B	W0
    BRA		Z,		FIN_PRINT
    
    CALL	_BusyFlag
    CALL	_datoLCD		    ;Recibe W0
    GOTO	LEER_CARACTER

FIN_PRINT:
    POP	    W1
    POP	    W0
    RETURN
    
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
    PUSH	W1
    PUSH	W2
    CLR		W2
    
    MOV		#0X00FF,	W1
    NOP
    MOV		TRISB,		W2
    NOP
    IOR		W1,		W2,		W2
    MOV		W2,		TRISB
    NOP
    
    BCLR	PORTD,		#RS_LCD
    NOP
    BSET	PORTD,		#RW_LCD
    NOP
    BSET	PORTD,		#E_LCD
    
 CICLO:
    BTSC	PORTB,		#BF_LCD
    GOTO	CICLO
    
    BCLR	PORTD,		#E_LCD
    BCLR	PORTD,		#RW_LCD
    
    MOV		#0XFF00,	W1    
    NOP
    AND		W2,		W1,		W2
    MOV		W2,		TRISB
    NOP
    
    POP		W2
    POP		W1
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
    