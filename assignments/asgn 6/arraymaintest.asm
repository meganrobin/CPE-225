.globl main
#int main() {
main:
        li      sp, 0x7ffffe00
        addi    sp, sp, -48
        sw      ra, 44(sp)
        sw      s0, 40(sp)


#   int arr[SIZE] = { 3, 5, 8, 4, 1, 9, -2, 2, 0, 6 };
        li      t0, 3
        sw      t0, 0(sp)
        li      t0, 5
        sw      t0, 4(sp)
        li      t0, 8
        sw      t0, 8(sp)
        li      t0, 4
        sw      t0, 12(sp)
        li      t0, 1
        sw      t0, 16(sp)
        li      t0, 9
        sw      t0, 20(sp)
        li      t0, -2
        sw      t0, 24(sp)
        li      t0, 2
        sw      t0, 28(sp)
        li      t0, 0
        sw      t0, 32(sp)
        li      t0, 6
        sw      t0, 36(sp)

#init saved registers.
        li      s0, -1
        li      s1, -1
        li      s2, -1
        li      s3, -1
        li      s4, -1
        li      s5, -1
        li      s6, -1
        li      s7, -1
        li      s8, -1
        li      s9, -1
        li      s10, -1
        li      s11, -1

#init temp registers.
        li      t0, -1
        li      t1, -1
        li      t2, -1
        li      t3, -1
        li      t4, -1
        li      t5, -1
        li      t6, -1

#init arg registers.
        li      a0, -1
        li      a1, -1
        li      a2, -1
        li      a3, -1
        li      a4, -1
        li      a5, -1
        li      a6, -1
        li      a7, -1
        
#    printArray(arr, n);
        mv      a0, sp
        li      a1, 10
        jal printArray
        
#    selectionSort(arr, 0, n);
        mv      a0, sp
        mv      a1, zero
        li      a2, 10
        jal     selectionSort
 
#    printArray(arr, n);
        mv      a0, sp
        li      a1, 10
        jal 	 printArray
 
#    check callee saved registers.
        jal 	 checkregisters
        li      sp, 0x7ffffd00
#    return 0;

        lw      ra, 44(sp)
        lw      s0, 40(sp)
        addi    sp, sp, 48
        addi    a7, x0, 10
        ecall


######################################################################v
#void printArray(int arr[], int n) {
printArray:
        addi    sp, sp, -16
        sw      ra, 12(sp)
        sw      s0, 8(sp)
        sw      s1, 4(sp)
        sw      s2, 0(sp)
        mv      s0, a0
        mv      s1, a1
        
#    int i; #allocate to t0 register

#    for (i = 0; i < n; i++) {
for:
        mv  s2, x0

# i < n;
forloop:
        bge     s2, s1 endfor

#   printf("%d ", arr[i]);

        slli    t0, s2, 2  # multiply index by 4
        add     t1, s0, t0 # add full index to base address.
        lw      a0, 0(t1)  # load arr[i]
       
        li      a7, 1
        ecall              #print the number

        li      a0, 0x20
        li      a7, 11
        ecall              # print a space
        
#i++
        addi    s2, s2, 1  # increment i
        b       forloop
#    }
endfor:
	#finish off with a newline
        li	a0, '\n'
        li	a7,	11
        ecall

#return from void function
        lw      ra, 12(sp)
        lw      s0, 8(sp)
        lw      s1, 4(sp)
        lw      s2, 0(sp)
        addi    sp, sp, 16
        ret
#}

checkregisters:
	li 	t1, 1
     	li   t0, 0x7ffffdd0

	beq	t0, sp, SPOK
#sp corrupted
	la a0, spmsg
	li a7 4
	ecall
	li	t1, 0
SPOK:
	li   t0, -1
     beq	t0, s0, S0OK
#s0 corrupted
	la a0, s0msg
	li a7 4
	ecall
	li	t1, 0
S0OK:
     beq	t0, s1, S1OK
#s1 corrupted
	la a0, s1msg
	li a7 4
	ecall
	li	t1, 0
S1OK:

     beq	t0, s2, S2OK
#s2 corrupted
	la a0, s2msg
	li a7 4
	ecall
	li	t1, 0
S2OK:

     beq	t0, s3, S3OK
#s3 corrupted
	la a0, s3msg
	li a7 4
	ecall
	li	t1, 0
S3OK:

     beq	t0, s4, S4OK
#s4 corrupted
	la a0, s4msg
	li a7 4
	ecall
	li	t1, 0
S4OK:

     beq	t0, s5, S5OK
#s5 corrupted
	la a0, s5msg
	li a7 4
	ecall
	li	t1, 0
S5OK:

     beq	t0, s6, S6OK
#s6 corrupted
	la a0, s6msg
	li a7 4
	ecall
	li	t1, 0
S6OK:

     beq	t0, s7, S7OK
#s7 corrupted
	la a0, s7msg
	li a7 4
	ecall
	li	t1, 0
S7OK:

     beq	t0, s8, S8OK
#s8 corrupted
	la a0, s8msg
	li a7 4
	ecall
	li	t1, 0
S8OK:

     beq	t0, s9, S9OK
#s9 corrupted
	la a0, s9msg
	li a7 4
	ecall
	li	t1, 0
S9OK:

     beq	t0, s10, S10OK
#s10 corrupted
	la a0, s10msg
	li a7 4
	ecall
	li	t1, 0
S10OK:

     beq	t0, s11, S11OK
#s11 corrupted
	la a0, s11msg
	li a7 4
	ecall
	li	t1, 0
S11OK:

#check pass flag
     beqz	t1 NOPASS
	la a0, passmsg
	li a7 4
	ecall
NOPASS:
ret

.data
spmsg:	.string	 "SP not restored.\n"
s0msg:	.string	 "S0 not preserved.\n"
s1msg:	.string	 "S1 not preserved.\n"
s2msg:	.string	 "S2 not preserved.\n"
s3msg:	.string	 "S3 not preserved.\n"
s4msg:	.string	 "S4 not preserved.\n"
s5msg:	.string	 "S5 not preserved.\n"
s6msg:	.string	 "S6 not preserved.\n"
s7msg:	.string	 "S7 not preserved.\n"
s8msg:	.string	 "S8 not preserved.\n"
s9msg:	.string	 "S9 not preserved.\n"
s10msg:	.string	 "S10 not preserved.\n"
s11msg:	.string	 "S11 not preserved.\n"
passmsg:	.string	 "Callee Saved registers check passes.\n"
