#Name: Megan Robinson
.globl printint, printstring, printchar, readchar, readint, exit0, readstring # labels ‘printint, printstring, printchar, readchar, readint, exit0’ are visible to operating system and other programs
.text # text directive that defines where the program instructions go
printint:
	li a7, 1 # put value 1 into a7 to indicate printint
	ecall # ecall to print the int in a0
	ret # return back to caller
printstring:
	li a7, 4 # put value 4 into a7 to indicate printstring
	ecall # ecall to print the string in a0
	ret # return back to caller
printchar:
	li a7, 11 # put value 11 into a7 to indicate printchar
	ecall # ecall to print the char in a0
	ret # return back to caller
readchar:
	li a7, 12 # put value 12 into a7 to indicate readchar
	ecall # ecall to read the char in a0
	ret # return back to caller
readint:
	li a7, 5 # put value 5 into a7 to indicate readint
	ecall # ecall to read the int in a0
	ret # return back to caller
exit0:
	li a7, 10 # put value 10 into a7 to indicate exit
	ecall # ecall to exit the program
readstring: # the argument(A.K.A. a0) is the address of where to store the string
	la t1, saveds0 # load address of saveds0 into t1
	la t2, savedra # load address of savedra into t2
	sw s0, 0(t1) # store whatever was in saved register s0 so that readchar can't mess with s0
	sw ra, 0(t2) # store the return address(which is in ra) since calling readchar messes with the ra
	mv s0, a0 # move address of where to store the string into s0
	
	loop:
		jal readchar
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