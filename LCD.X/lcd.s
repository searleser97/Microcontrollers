
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
    
_funcion1:
    PUSH    W0
    MOV	    #3,	W0
    MOV	    W0,	_var
    
    POP	    W0
    return

_funcion2:
    PUSH    W1
    PUSH    W0
    MOV	    #12,    W0
    MOV	    #3,	    W1
    ADD	    W0,	    W1,	    W0
    
    POP	    W0
    POP	    W1
    return 

_funcion3:
    ADD	    W0,	    W1,	    W0	
    
    return

_funcion4:
   PUSH	    W1
   PUSH	    W2
   CLR	    W2
CICLO:
    MOV.B   [W0++],   W1
    CP0.B	    W1
    BRA	    Z,	    FIN	
    INC	    W2,	    W2
    GOTO    CICLO
    
    FIN:
    MOV	    W2,	    W0
    
    POP	    W2
    POP	    W1
    return
 
_comandoLCD:
    CLR	    TRISD
    NOP
    
    
    BCLR    PORTD,  #RS_LCD
    NOP
    BCLR    PORTD,  #RW_LCD
    NOP
    BSET    PORTD,  #E_LCD
    NOP
    
    MOV.B    WREG,    PORTB
    NOP  
    
    BCLR     PORTD, #E_LCD
    NOP
    return
    
_datoLCD:
    CLR    TRISD
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
    PUSH    W0
    CLR    TRISD
    BCLR    PORTD,  #RS_LCD
    NOP
    
    SETM.B  TRISB
    NOP
    
    BSET    PORTD,  #RW_LCD
    NOP
    
    BSET    PORTD,  #E_LCD
    NOP
PROCESA:
    BTSC    PORTB,  #BF_LCD
    GOTO    PROCESA
    
    BCLR    PORTD,#E_LCD
    NOP
    BCLR    PORTD,  #RW_LCD
    NOP
    
    SETM    TRISB
    NOP
    CLR.B   TRISB
    NOP
    
    POP	    W0
    return
    

    
_iniLCD8Bits:
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
  
    return 
    
RETARDO_15ms:
    PUSH    W0
    PUSH    W1	
    CLR	    W0
CICLO1_1S:
    DEC	    W0,	    W0
    BRA	    NZ,	    CICLO1_1S

    POP	    W1
    POP	    W0
    return
  