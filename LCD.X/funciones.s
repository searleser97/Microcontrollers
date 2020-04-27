.include "p30F4013.inc"

.GLOBAL	_funcion1
.GLOBAL	_funcion2
.GLOBAL	_funcion3
.GLOBAL	_funcion4
.GLOBAL	_var

_funcion1:
    MOV	    _var,   W2
    ADD	    W2,	    #3,	    W2
    return
    
_funcion2:
    PUSH    W1
    
    MOV	    #8,	    W0
    MOV	    #10,    W1
    ADD	    W0,	    W1,	    W0
    
    POP	    W1
    return

_funcion3:
    PUSH    W1
    
    ADD	    W0,	    W1,	    W0	
    
    POP	    W1
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