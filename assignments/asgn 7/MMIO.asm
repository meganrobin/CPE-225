#Name: Megan Robinson
.globl printInt, printString, printChar, readChar, readInt, exitProgram, readString # labels ‘printint, printstring, printchar, readchar, readint, exit0’ are visible to operating system and other programs
.text # text directive that defines where the program instructions go
printInt:
	lw t1, TCR # get TCR addr
	lw t0, (t1) # get TCR value
	andi t0, t0, 1
	beq t0, zero, printInt # loops back to printInt if the value in TCR is 0
	lw t1, TDR
	addi a0, a0, 48 # convert char representation of the int into the actual int that you want
	sw a0, (t1) # write int
	ret
printString:
	la t1, saveds0 # load address of saveds0 into t1
	la t2, savedra # load address of savedra into t2
	sw s0, 0(t1) # store whatever was in saved register s0 so that readchar can't mess with s0
	sw ra, 0(t2) # store the return address(which is in ra) since calling readchar messes with the ra
	mv s0, a0 # move address of where the string is stored into s0
	
	printLoop:
		li t1, '\0' # set t1 to the null char
		lbu a0, 0(s0)
		beq t1, a0, endPrintLoop # branch to endloop if the char is null char
		jal printChar
		addi s0, s0, 1 # increment address by 1
		b printLoop
		
	endPrintLoop:
	lw s0, saveds0 # restore s0
	lw ra, savedra # restore a0
	ret
printChar:
	lw t1, TCR # get TCR addr
	lw t0, (t1) # get TCR value
	andi t0, t0, 1
	beq t0, zero, printChar # loops back to printChar if the value in TCR is 0
	lw t1, TDR
	sw a0, (t1) # write char
	ret
readChar:
	lw t1, RCR # get RCR addr
	lw t0, (t1)# get RCR value
	andi t0, t0, 1
	beq t0, zero, readChar # loops back to readChar if the value in RCR is 0
	lw t1, RDR # get RDR addr
	lbu a0, (t1) # read char
	ret
readInt:
	lw t1, RCR # get RCR addr
	lw t0, (t1)# get RCR value
	andi t0, t0, 1
	beq t0, zero, readInt # loops back to readInt if the value in RCR is 0
	lw t1, RDR # get RDR addr
	lw t2, (t1) # read int into t2
	addi a0, t2, -48 # convert char representation of the int into the actual int that you want
	ret
exitProgram:
	li a7, 10 # put value 10 into a7 to indicate exit
	ecall # ecall to exit the program
readString: # the argument(A.K.A. a0) is the address of where to store the string
	la t1, saveds0 # load address of saveds0 into t1
	la t2, savedra # load address of savedra into t2
	sw s0, 0(t1) # store whatever was in saved register s0 so that readchar can't mess with s0
	sw ra, 0(t2) # store the return address(which is in ra) since calling readchar messes with the ra
	mv s0, a0 # move address of where to store the string into s0
	
	loop:
		jal readChar
		li t1, 10 # set t1 to 10, which is '\n' (the newline char)
		beq t1, a0, endloop # branch to endloop if the char is '\n'
		sb a0, 0(s0)
		addi s0, s0, 1 # increment address by 1
		b loop
		
	endloop:
	li t1, '\0'
	sb t1, 0(s0)
	lw s0, saveds0 # restore s0
	lw ra, savedra # restore a0
	ret
.data
saveds0: .word 0
savedra: .word 0

RCR: .word 0xffff0000
RDR: .word 0xffff0004
TCR: .word 0xffff0008
TDR: .word 0xffff000c
