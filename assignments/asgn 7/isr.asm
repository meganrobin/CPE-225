 #Name: Megan Robinson
.global initialization, handler
.text # text directive that defines where the program instructions go
initialization: # set up for the handler and enable interrupts
	addi sp, sp, -16 # make room on stack
	sw ra, 12(sp)
	sw a0, 8(sp)
	
	la t0, handler # load address of handler
	csrrw zero, utvec, t0 # set utvec(5) to the handler’s address
        csrsi uie, 0x100 # enable receiving of a device interrupt - set uie bit 8
        la t0, RCR # enable the external device (MMIO) to send interrupts
        lw t1,(t0)
        li t2, 2 # is bit 1 of RCR set?
	sw t2,(t1)
        csrrsi zero, ustatus, 1 # enable global interrupt checking - set ustatus
	
	la	a0, startmsg # print start message
	jal	printString
	
	lw a0, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16 # pop stack
	ret
	
handler:
	addi sp, sp, -32 # make room on stack
	sw ra, 20(sp)
	sw s0, 12(sp)
	sw t0, 8(sp)
	sw t1, 4(sp)
	sw t2, 0(sp)
	
	lw t1, RDR # get RDR addr
	lbu s0, (t1) # read char
	
	la	a0, keypressedmsg # print key pressed message
	jal	printString
	
	mv a0, s0 # move char pressed into a0
	jal printChar # print char
	
	la	a0, newlinemsg # print newline
	jal	printString
	
	# increment counter
	la t1, count # load address of count
	lw t0,(t1)
	addi t0, t0, 1  # counter += 1
	li t1, 5
	if:
	bne t0, t1, end_if # b to end_if when count != 5, else resets count and sets uepc to main
	la t1, count
	sw zero,(t1) # reset count
	la t0, main # load address of main
	csrrw zero, 65, t0 # set uepc to address of main
	b exit_handler
	end_if:
	la t1, count # store counter back to .data
	sw t0,(t1)
	
	exit_handler:
	mv a0, s0 # move char pressed back into a0
	lw t2, 0(sp)
	lw t1, 4(sp)
	lw t0, 8(sp)
	lw s0, 12(sp)
	lw ra, 20(sp)
	addi sp, sp, 32 # restore stack
	
	uret # return to user program
.data
RCR: 	.word 0xffff0000
RDR: 	.word 0xffff0004
count: 	.word 0
startmsg:	.string "\nInitializing Interrupts\n"
keypressedmsg:	.string	"\nKey Pressed is: "
newlinemsg:     .string "\n"
