; ��4.3


STACK SEGMENT STACK 'STACK' 
      DW 100H DUP(?)
TOP LABEL WORD 
STACK   ENDS 
DATA    SEGMENT
BUFFER  DW  500 
DATABUF DW  500 DUP(0) ;��ʼ���������������
GREATZ  DW ? 
ZERO    DW ? 
LITTLEZ DW ? 
DATA    ENDS 
CODE    SEGMENT 
        ASSUME CS : CODE, DS : DATA, ES : DATA, SS : STACK 
         
START:  
    MOV AX, DATA 
    MOV DS, AX 
    MOV ES, AX 
    MOV AX, STACK 
    MOV SS, AX 
    LEA SP, TOP 
    XOR AX, AX 
    MOV GREATZ, AX 
    MOV ZERO, AX 
    MOV LITTLEZ, AX 
          
    MOV CX, BUFFER        ;ѭ���������500����
    LEA SI, BUFFER+2
    MOV BX, 979
    MOV AX, 17
LOOP1:  
    MOV [SI],AL
    INC SI
    MOV [SI],AH
    INC SI
    ADD AX,BX
    LOOP LOOP1   
    
    MOV CX, BUFFER 
    LEA SI, BUFFER + 2
ST_COUNT: 

    MOV AX, [SI]
    ADD SI, 2 
    AND AX, AX 
    JLE COUNT1 
    INC GREATZ 
    JMP COUNT3 

COUNT1: 

    JL COUNT2 
    INC ZERO 
    JMP COUNT3 

COUNT2: 

    INC LITTLEZ 

COUNT3: 

    DEC CX 
    JNZ ST_COUNT 
    MOV AH, 4CH 
    INT 21H 
CODE ENDS 
     END START