AREA RegisterOnly, CODE, READONLY
ENTRY
LDR R0, =array ; 
MOV R1, #COUNT ; 

LDRB R4, [R0], #1 ; 
MOV R5, R4 ; 
SUBS R1, R1, #1 ; 
BEQ done ;
find_loop
LDRB R6, [R0], #1 ;

CMP R6, R4
MOVGTR4, R6 ;

CMP R6, R5
MOVLT R5, R6 ; 
SUBS R1, R1, #1 ;
BNE find_loop ; 

stop B stop
AREA data1, DATA, READONLY
array
DCB 12, 45, 3, 78, 23, 56, 89, 1, 34, 67, 90, 2, 45, 6, 78, 32
DCB 11, 44, 77, 99, 22, 55, 88, 0, 33, 66, 9, 21, 54, 87, 10, 43

COUNT EQU 32 
END
