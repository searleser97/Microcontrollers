
    .include	"p30F4013.inc"

    .GLOBAL	_funcion1
    .GLOBAL	_funcion2
    .GLOBAL	_funcion3
    .GLOBAL	_funcion4
    .GLOBAL	_var
    .GLOBAL	_comandoLCD
    .GLOBAL	_datoLCD
    .GLOBAL	_busyFlagLCD
    .GLOBAL	_iniLCD8Bits
    .EQU	RS_LCD,	RD0
    .EQU	RW_LCD,	RD1
    .EQU	E_LCD,	RD2
    .EQU	BF_LCD,	RB7
 
_comandoLCD:
    BCLR    PORTD,  #RS_LCD
    NOP
    BCLR    PORTD,  #RW_LCD
    NOP
    BSET    PORTD,  #E_LCD
    NOP
    
    MOV.B    WREG,  PORTB
    NOP  
    
    BCLR     PORTD, #E_LCD
    NOP
    return
    
_datoLCD:
    BSET   PORTD,  #RS_LCD
    NOP
    BCLR    PORTD,  #RW_LCD
    NOP
    BSET    PORTD,  #E_LCD
    NOP
    
    MOV.B    WREG,    PORTB
    NOP
    
    BCLR    PORTD, #E_LCD
    NOP
    
    return
    
_busyFlagLCD:
    CLR    TRISB
    NOP
    
    SETM.B  TRISB
    NOP
    
    BCLR    PORTD,  #RS_LCD
    NOP
    
    BSET    PORTD,  #RW_LCD
    NOP
    
    BSET    PORTD,  #E_LCD
    NOP

PROCESA:
    BTSC    PORTB,  #BF_LCD
    GOTO    PROCESA
    
    BCLR    PORTD,  #E_LCD
    NOP
    BCLR    PORTD,  #RW_LCD
    NOP
    
    SETM    TRISB
    NOP
    CLR.B   TRISB
    NOP
    return
    

    
_iniLCD8Bits:
    PUSH W0
    
    CLR	    W0
    CALL    RETARDO_15ms
    MOV	    #0x30,  W0
    CALL    _comandoLCD
    
    CALL    RETARDO_15ms
    MOV	    #0x30,  W0
    CALL    _comandoLCD
    
    CALL    RETARDO_15ms
    MOV	    #0x30,  W0
    CALL    _comandoLCD
    
    CALL    _busyFlagLCD
    MOV	    #0x38,  W0
    CALL    _comandoLCD
    
    CALL    _busyFlagLCD
    MOV	    #0x08,  W0
    CALL    _comandoLCD
    
    CALL    _busyFlagLCD
    MOV	    #0x01,  W0
    CALL    _comandoLCD
    
    CALL    _busyFlagLCD
    MOV	    #0x06,  W0
    CALL    _comandoLCD
    
    CALL    _busyFlagLCD
    MOV	    #0x0F,  W0
    CALL    _comandoLCD
    
    POP W0
    return 
    
RETARDO_15ms:
    NOP
    NOP
    return
  