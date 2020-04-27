	.include "p30F4013.inc"
	.GLOBAL _datoLCD
	.GLOBAL _comandoLCD
	.GLOBAL _BFLCD
	.GLOBAL _iniLCD8bits
	
	.EQU RDO, RS_LCD
	.EQU RD1, RW_LCD
	.EQU RD2, E_LCD
	.EQU RD7, BF_LCD
	
_datoLCD:
    BSET PORTD, #RS_LCD
    NOP
    BCLR PORTD, #RW_LCD  
    NOP
    BSET PORTD, #E_LCD
    NOP
    MOV.B WREG, PORTB
    NOP
    BCLR PORTD, #E_LCD
    NOP
    RETURN
    
_comandoLCD:
    BCLR PORTD, #RS_LCD	; RS = 0
    NOP
    BCLR PORTD, #RW_LCD ;RW = 0  
    NOP
    BSET PORTD, #E_LCD ;E = 1
    NOP
    MOV.B WREG, PORTB ;PORTB = W0
    NOP
    BCLR PORTD, #E_LCD ;E=0
    NOP
    RETURN
    
_BFLCD:
   RETURN
   
_iniLCD8bits:
    RETURN
    


