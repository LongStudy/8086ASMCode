; Àý4.24


STACK   SEGMENT STACK 'STACK'
        DW 100H DUP(?)
TOP     LABEL WORD
STACK   ENDS
DATA    SEGMENT
TAXRATE DW 5,10,15,20,25,30,35,40,45
DEDUCTION   DW 0,25,125,375,1375,3375,6375,10375,15375
INCOME  LABEL WORD
        DD 500,2000,5000,20000,40000,60000,80000,100000,300000
XDAT    DW 10,1600
        DD 1200,2600,3000,4000,5000,6000,7000,8000
        DD 9000,10000
YDAT    DW 0
        DD 50 DUP(0)
DATA    ENDS
CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA,ES:DATA,SS:STACK
START:
        MOV AX,DATA
        MOV DS,AX
        MOV ES,AX
        MOV AX,STACK
        MOV SS,AX
        LEA SP,TOP
        LEA SI,XDAT
        MOV CX,[SI]
        ADD SI,2
        MOV BX,[SI]
        ADD SI,2
        LEA DI,YDAT+6
        MOV YDAT,CX
        MOV YDAT+2,0
        MOV YDAT+4,0
L1:
        MOV AX,[SI]
        MOV DX,[SI+2]
        ADD SI,4
        CALL INCOMERATE
        MOV [DI],AX
        MOV [DI+2],DX
        ADD DI,4
        ADD YDAT+2,AX
        ADC YDAT+4,DX
        XCHG AX,DX
        CALL DISPAX
        XCHG AX,DX
        CALL DISPAX
        CALL DISPCR
        LOOP L1
        CALL DISPCR
        MOV AX,YDAT+4
        CALL DISPAX
        MOV AX,YDAT+2
        CALL DISPAX
        CALL DISPCR
        MOV AH,4CH
        INT 21H
INCOMERATE  PROC NEAR
        PUSH BX
        PUSH CX
        PUSH SI
        SUB AX,BX
        SBB DX,0
        JS INCRATE4
        XOR BX,BX
        XOR SI,SI
        MOV CX,9
INCRATE1:
        CMP DX,INCOME[BX][SI+2]
        JB INCRATE2
        JA INCRATE3
        CMP AX,INCOME[BX][SI]
        JB INCRATE2
INCRATE3:
        ADD BX,2
        ADD SI,2
        LOOP INCRATE1
INCRATE2:
        PUSH AX
        MOV AX,DX
        MUL TAXRATE[BX]
        POP CX
        PUSH AX
        MOV AX,CX
        MUL TAXRATE[BX]
        POP CX
        ADD DX,CX
        MOV CX,100
        CALL COMPT4DIV1
        SUB AX,DEDUCTION[BX]
        SBB DX,0
        JMP INCRATE5
INCRATE4:
        MOV DX,0
        MOV AX,0
INCRATE5:
        POP SI
        POP CX
        POP BX
        RET
INCOMERATE  ENDP
COMPT4DIV1  PROC NEAR
        PUSH BX
        PUSH CX
        PUSH SI
        XOR CH,CH
        CMP CX,1
        JE COMPTDIV1
        MOV SI,CX
        PUSH AX
        MOV AX,DX
        XOR DX,DX
        XOR BX,BX
        XOR CX,CX
        PUSH AX
        XOR AL,AL
        XCHG AL,AH
        DIV SI
        ADD BH,AL
        MOV AH,DL
        POP DX
        MOV AL,DL
        XOR DX,DX
        DIV SI
        ADD BL,AL
        ADC BH,AH
        MOV AH,DL
        POP DX
        PUSH DX
        MOV AL,DH
        XOR DX,DX
        DIV SI
        ADD CH,AL
        ADC BL,AH
        MOV AH,DL
        POP DX
        MOV AL,DL
        XOR DX,DX
        DIV SI
        ADD CL,AL
        ADC CH,AH
        MOV AX,CX
        MOV DX,BX
COMPTDIV1:
        POP SI
        POP CX
        POP BX
        RET
COMPT4DIV1  ENDP 

DISPAL  PROC NEAR
        PUSH AX
        PUSH CX
        PUSH DX
        PUSH AX
        MOV CL,4
        SHR AL,CL
        CALL CHANG
        MOV AH,02
        MOV DL,AL
        INT 21H
        POP AX
        AND AL,0FH
        CALL CHANG
        MOV AH,02
        MOV DL,AL
        INT 21H
        POP DX
        POP CX
        POP AX
        RET
DISPAL  ENDP
CHANG  PROC NEAR 
       CMP AL,10
       JNGE CHANG1
       ADD AL,7
CHANG1:
       ADD AL,30H
       RET
CHANG  ENDP
DISPAX PROC NEAR
       XCHG AL,AH
       CALL DISPAL
       XCHG AH,AL
       CALL DISPAL
       RET
DISPAX ENDP

DISPCR  PROC NEAR
        PUSH AX
        PUSH DX
        MOV AH,2
        MOV DL,0AH
        INT 21H
        MOV AH,2
        MOV DL,0DH
        INT 21H
        POP DX
        POP AX
        RET 
DISPCR  ENDP

CODE    ENDS
        END START
