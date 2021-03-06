
;PORTF(1,2,3) config
SYSCTL_RCGCGPIO 		EQU 0x400FE608
GPIO_PORTF_DIR 			EQU 0x40025400
GPIO_PORTF_AFSEL 		EQU 0x40025420
GPIO_PORTF_DEN 			EQU 0x4002551C
GPIO_PORTF_AMSEL		EQU	0x40025528
	
			AREA  initialization1, READONLY, CODE
			THUMB
			EXPORT LedModule_init


LedModule_init	PROC
	PUSH{LR,R0-R1}
	LDR R1 ,=SYSCTL_RCGCGPIO
	LDR R0,[R1]
	ORR R0,R0,#0x20 ; Open Clock for PortF, set bit6
	STR	R0,[R1]
	NOP
	NOP
	NOP
	LDR R1,=GPIO_PORTF_AMSEL
	LDR R0,[R1]
	BIC	R0,#0x0E ; No AMSEL for F1,F2,F3
	STR R0,[R1]
	LDR R1,=GPIO_PORTF_DIR
	LDR R0,[R1]
	ORR R0,#0x0E ; F1,F2,F3 output
	STR R0,[R1]
	LDR R1,=GPIO_PORTF_AFSEL
	LDR R0,[R1]
	BIC R0,#0x0E ; No AFSEL for F1,F2,F3
	STR R0,[R1]
	LDR R1,=GPIO_PORTF_DEN
	LDR R0,[R1]
	ORR R0,#0x0E ; F1,F2,F3 Digital Enable
	STR R0,[R1]
	POP{LR,R0-R1}
			BX LR
			ENDP
			ALIGN
			END