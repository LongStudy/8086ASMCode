; ϰ��4.5



STACK 	SEGMENT STACK 'STACK'
		DW 100H DUP(?)
TOP 	LABEL WORD
STACK 	ENDS
DATA 	SEGMENT
        VAR1 DB 27
        VAR2 DB 37
DATA 	ENDS
CODE 	SEGMENT 
		ASSUME CS:CODE,DS:DATA,ES:DATA,SS:STACK  

START:
    MOV AX,DATA
    MOV DS,AX
    MOV ES,AX
    MOV AX,STACK
    MOV SS,AX
    LEA SP,TOP
    XOR AX,AX

    MOV AL,VAR1
    MOV BL,VAR2
    TEST AL,1
    JZ EVEN1
    JMP OVER
EVEN1:
    TEST BL,1
    JZ EVEN2
    MOV VAR1,BL
    MOV VAR2,AL
    JMP OVER
EVEN2:
    SHR AL,1
    MOV VAR1,AL
    SHR BL,1
    MOV VAR2,BL
OVER:
    MOV AH,4CH
    MOV AL,0
    INT 21H

CODE ENDS 
     END START    
