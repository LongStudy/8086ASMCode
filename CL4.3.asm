; ϰ��4.3


STACK 	SEGMENT STACK 'STACK'
		DW 100H DUP(?)
TOP 	LABEL WORD
STACK 	ENDS
DATA 	SEGMENT
        VAR DW 123,234,456
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

    XOR SI,SI
    MOV AX,VAR[SI]
    CMP AX,VAR[SI+2]
    JAE L1
    XCHG AX,VAR[SI+2]
L1:
    CMP AX,VAR[SI+4]
    JAE L2
    XCHG AX,VAR[SI+4]
L2:
    MOV VAR[SI],AX
    MOV AX,VAR[SI+2]
    CMP AX,VAR[SI+4]
    JAE L3
    XCHG AX,VAR[SI+4]
L3:
    MOV VAR[SI+2],AX
    MOV AX,8000H
    ADD AX,VAR[SI]
    JNC L4
    ADD AX,VAR[SI]
    JNC L4
    ADD AX,VAR[SI]
    JNC L4
    JMP OVER
L4: 
    MOV AX,VAR[SI]
    MOV BX,VAR[SI+4]
    MOV VAR[SI],BX
    MOV VAR[SI+4],AX
OVER:
    MOV AH,4CH
    MOV AL,0
    INT 21H     
CODE ENDS 
     END START
