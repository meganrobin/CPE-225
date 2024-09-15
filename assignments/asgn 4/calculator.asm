# Name: Megan Robinson
.globl main # make label ‘main’ visible to operating system and other programs
.text # text directive that defines where the program instructions go
main:
	li s0, 0 # load 0 into s0, s0 is incrementer for total operations
	li s5, 110 # load 110 into s5, which is the binary representation of the char 'n'
	
	# print intro string
	la a0, intro_str
	jal printstring
while:
	# print total operations performed string
	la a0, total_ops_str 
	jal printstring
	# print the total number of operations performed
	mv a0, s0 
	jal printint
	
	# print first number string
	la a0, first_num_str 
	jal printstring
	# store user's first int in s1
	jal readint
	mv s1, a0 
	
	# print second number string
	la a0, second_num_str
	jal printstring
	# store user's second int in s2
	jal readint
	mv s2, a0 
	
	# print select operation string
	la a0, select_op_str
	jal printstring
	# store user's operation choice in s3
	jal readint
	mv s3, a0 
	
	la a0, result_str # print result string
	jal printstring
	
	if:
		li t0, 1
		bne s3, t0, elif1 # go to next elif if the user's chosen operation != 1
		# move num1 and num2 into a0 and a1, respectively
		mv a0, s1
		mv a1, s2
		jal addnums # jal to addnums subroutine
		mv s4, a0 # store result of addnums in s4
		b endif # branch to end of if statement
	elif1:
		li t0, 2
		bne s3, t0, elif2 # go to next elif if the user's chosen operation != 2
		# move num1 and num2 into a0 and a1, respectively
		mv a0, s1
		mv a1, s2
		jal subnums # jal to subnums subroutine
		mv s4, a0 # store result of subnums in s4
		b endif # branch to end of if statement
	elif2:
		li t0, 3
		bne s3, t0, elif3 # go to next elif if the user's chosen operation != 3
		# move num1 and num2 into a0 and a1, respectively
		mv a0, s1
		mv a1, s2
		jal multnums # jal to multnums subroutine
		mv s4, a0 # store result of multnums in s4
		b endif # branch to end of if statement
	elif3:		
		li t0, 4
		bne s3, t0, elif4 # go to next elif if the user's chosen operation != 4
		# move num1 and num2 into a0 and a1, respectively
		mv a0, s1
		mv a1, s2
		jal divnums # jal to divnums subroutine
		mv s4, a0 # store result of divnums in s4
		b endif # branch to end of if statement
	elif4:
		li t0, 5
		bne s3, t0, elif5 # go to next elif if the user's chosen operation != 5
		# move num1 and num2 into a0 and a1, respectively
		mv a0, s1
		mv a1, s2
		jal andnums # jal to andnums subroutine
		mv s4, a0 # store result of andnums in s4
		b endif # branch to end of if statement
	elif5:
		li t0, 6
		bne s3, t0, elif6 # go to next elif if the user's chosen operation != 6
		# move num1 and num2 into a0 and a1, respectively
		mv a0, s1
		mv a1, s2
		jal ornums # jal to ornums subroutine
		mv s4, a0 # store result of ornums in s4
		b endif # branch to end of if statement
	elif6:
		li t0, 7
		bne s3, t0, elif7 # go to next elif if the user's chosen operation != 7
		# move num1 and num2 into a0 and a1, respectively
		mv a0, s1
		mv a1, s2
		jal xornums # jal to xornums subroutine
		mv s4, a0 # store result of xornums in s4
		b endif # branch to end of if statement
	elif7:
		li t0, 8
		bne s3, t0, elif8 # go to next elif if the user's chosen operation != 8
		# move num1 and num2 into a0 and a1, respectively
		mv a0, s1
		mv a1, s2
		jal lshiftnums # jal to lshiftnums subroutine
		mv s4, a0 # store result of lshiftnums in s4
		b endif # branch to end of if statement
	elif8:
		li t0, 9
		bne s3, t0, else # go to else if the user's chosen operation != 9
		# move num1 and num2 into a0 and a1, respectively
		mv a0, s1
		mv a1, s2
		jal rshiftnums # jal to rshiftnums subroutine
		mv s4, a0 # store result of rshiftnums in s4
		b endif # branch to end of if statement
	else:
		la a0, invalid_str # print invalid operation number string if an int 1-9 wasn't chosen
		jal printstring
		b endif_invalid
	endif:
	mv a0, s4 # move result to a0
	jal printint # print result
	
	endif_invalid: # label to branch to if user enter an invalid operation
	addi s0, s0, 1 # increment total operations by 1
	
	la a0, continue_str # put address of continue_str into a0
	jal printstring
	
	jal readchar # ecall to read a char from input console
	mv t1, a0 # store user char in t1
	cont_if: # label to indicate where the continue if statement starts
		beq t1, s5, end # branch to end if the user char is 'n'
		b while # branch to while if the user char is anything other than 'n'
	
	end:
		la a0, total_ops_str # print total operations performed string
		jal printstring
		mv a0, s0 # print the number of total operations performed
		jal printint
		
		la a0, exit_str # print exiting string
		jal printstring
		jal exit0

.data # data directive defines where the program data goes
intro_str: .string "Welcome to the Calculator program.\nOperations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor 8:lshift 9:rshift"
total_ops_str: .string "\n\nNumber of operations performed: "
first_num_str: .string "\nEnter number: "
second_num_str: .string "Enter second number: "
select_op_str: .string "Select operation: "
invalid_str: .string "Invalid Operation"
result_str: .string "Result: "
continue_str: .string "\nContinue (y/n)?: "
exit_str: .string "\nExiting"