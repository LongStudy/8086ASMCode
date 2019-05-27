; ��4.26


STACK SEGMENT STACK 'stack'
      DW 256H DUP(?)
TOP   LABEL WORD
STACK ENDS
      N = 30
      M = 10
DATA  SEGMENT
NUM   DW N
AVG   DB N DUP(0)
MIN   DB N DUP(0)
N1    DB 0
N2    DW 0
BUF1  DB N DUP(0)
BUF2  DW N DUP(0)
DATA  ENDS
CODE  SEGMENT
      ASSUME CS:CODE,DS:DATA,ES:DATA,SS:STACK
START:
      MOV AX,DATA
      MOV DS,AX
      MOV ES,AX
      MOV AX,STACK
      MOV SS,AX
      MOV SP,TOP
      MOV CX,NUM
      CALL PRODUCT
      XOR SI,SI
      XOR DI,DI
      XOR BX,BX
      MOV CX,NUM
ELIMINATE:
      CMP MIN[SI],60
      JB  ELIMINATE1
      MOV AL,AVG[SI]
      MOV BUF1[DI],AL
      INC DI
      MOV BUF2[BX],SI
      ADD BX,2
ELIMINATE1:
      INC SI
      LOOP ELIMINATE
      MOV CX,DI
      LEA SI,BUF1
      LEA DI,BUF2
      CALL SORT
      CMP CX,M
      JBE MATRI00
      MOV CX,M
MATRI00:
      MOV BX,CX
      MOV AL,BUF1[BX-1]
      MOV N1,AL
      MOV N2,BX
      MOV AL,N1
      MOV AH,0
      CALL DISPAL
      CALL DISPCR
      MOV AX,N2
      CALL DISPAX
      CALL DISPCR
      MOV AH,4CH
      INT 21H
SORT  PROC NEAR
      PUSH AX
      PUSH CX
      PUSH SI
      PUSH DI
      DEC CX
      ADD SI,CX
      ADD DI,CX
      ADD DI,CX
LP1:
      PUSH CX
      PUSH SI
      PUSH DI
LP2:
      MOV AL,[SI]
      CMP AL,[SI-1]
      JBE NOXCHG
      XCHG AL,[SI-1]
      MOV [SI],AL
      MOV AX,[DI]
      XCHG AX,[DI-2]
      MOV DI,AX
NOXCHG:
      DEC SI
      DEC DI
      DEC DI
      LOOP LP2
      POP DI
      POP SI
      POP CX
      LOOP LP1
      POP DI
      POP SI
      POP CX
      POP AX
      RET
SORT  ENDP
PRODUCT PROC NEAR
      PUSH AX
      PUSH CX
      MOV AL,17
      MOV BH,59
      LEA SI,AVG
PR1:
      ADD AL,BH
      CMP AL,100
      JAE PR1
      CMP AL,40
      JB PR1
      MOV [SI],AL
      INC SI
      LOOP PR1
      POP CX
      MOV AL,5
      MOV BH,3
      LEA SI,AVG
      LEA DI,MIN
PR2:
      ADD AL,BH
      CMP AL,15
      JAE PR2
      MOV BL,[SI]
      SUB BL,AL
      MOV [DI],BL
      INC SI
      INC DI
      LOOP PR2
      POP AX
      RET
PRODUCT ENDP 
DISPAL	PROC NEAR
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
DISPAL	ENDP

CHANG PROC NEAR	
		CMP AL,10
		JNGE CHANG1
		ADD AL,7
CHANG1:
		ADD AL,30H
		RET
CHANG ENDP

DISPAX PROC NEAR
		XCHG AL,AH
		CALL DISPAL
		XCHG AH,AL
		CALL DISPAL
		RET
DISPAX ENDP
	
DISPCR	PROC NEAR
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
DISPCR	ENDP

CODE    ENDS
        END START
