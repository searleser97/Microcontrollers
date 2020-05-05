	.include "p30F4013.inc"
	.GLOBAL _RETARDO1s
	.GLOBAL _RETARDO15ms
    
;/***ESTA RUTINA GENERA UN RETARDO DE 1 seg ***/
_RETARDO1s:
    PUSH	W0
    PUSH	W1

    MOV		#9,	    W1

CICLO2_1s:
    ;MOV	#5,	    W0
    CLR		W0

CICLO1_1s:
    DEC		W0,	    W0
    BRA		NZ,	    CICLO1_1s

    DEC		W1,	    W1
    BRA		NZ,	    CICLO2_1s
    
    POP		W1,
    POP		W0
    RETURN

;/***ESTA RUTINA GENERA UN RETARDO DE 15 ms ***/
_RETARDO15ms:
    CALL	_RETARDO5ms
    CALL	_RETARDO5ms
    CALL	_RETARDO5ms
    RETURN

_RETARDO5ms:    
    PUSH	W0
    MOV		#3073,	    W0

CICLO_aux:
    DEC		W0,	    W0
    BRA		NZ,	    CICLO_aux
    
    POP		W0
RETURN