; 例4.1


org 100h

ASSUME CS:CODE,DS:DATA,ES:DATA ;取出DATA地址给AX,再传给段寄存器
MOV AX,DATA
MOV DS,AX
MOV ES,AX