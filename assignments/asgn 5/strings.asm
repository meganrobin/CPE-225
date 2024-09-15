#Name: Megan Robinson
.global strlen, strcmp, strcpy, strrev, strcat, strmix
.text # text directive that defines where the program instructions go

strlen:
	li t0, 0 # t0 is an incrementer that counts the number of chars
	whilelength:
		li t1, '\0' # set t1 to the null char '\0'
		add t2, t0, a0 # set t2 to the address of string[t0]
		lb t2, 0(t2) # load the char at the address of string[t0]
		beq t1, t2, endwhilelength # branch to endwhile if char is '\0'
		addi t0, t0, 1 # increment total number of chars by 1
		b whilelength
	endwhilelength:
	mv a0, t0
	ret

strcmp:
	li t0, 0 # t0 is an incrementer that counts the number of chars in the first string
	li t3, 0 # t3 is an incrementer that counts the number of chars in the second string
	while:
		li t1, '\0' # set t1 to the null char '\0'
		
		add t2, t0, a0 # set t2 to the address of string[t0]
		lb t2, 0(t2) # load the char at the address of string[t0]
		
		add t4, t3, a1 # set t4 to the address of string[t4]
		lb t4, 0(t4) # load the char at the address of string[t4]
		
		bne t2, t4, notequal # compare the two chars at the same index, branch to notequal if they're not equal
		
		beq t1, t2, endwhile # branch to endloop if char is '\0'
		addi t0, t0, 1 # increment total number of chars(in first string) by 1
		
		beq t1, t4, endwhile # branch to endloop if the char is '\0'
		addi t3, t3, 1 # increment total number of chars(in second string) by 1
		b while
	endwhile:
		beq t0, t3, equal # compare the two lengths, branch to equal if they're the same, otherwise it'll automatically go to the notequal label
	notequal:
		li a0, 1
		ret
	equal:
		li a0, 0
		ret
strcpy:
	whilecpy:
		li t1, '\0' # set t1 to the null char '\0'
		lb t2, 0(a0) # load the char at the address of string[t0]
		beq t2, t1, endwhilecpy # branch to endloop if the char is '\0'
		sb t2, 0(a1) 
		addi a0, a0, 1 # increment starting address by 1
		addi a1, a1, 1 # increment destination address by 1
		b whilecpy
	endwhilecpy:
		li t1, '\0'
		sb t1, 0(a1)
		mv a0, t0
		ret
strrev:
	li t0, 0 # t0 is an incrementer that counts the number of chars
	whilerevlen:
		li t1, '\0' # set t1 to the null char '\0'
		add t2, t0, a0 # set t2 to the address of string[t0]
		lb t2, 0(t2) # load the char at the address of string[t0]
		beq t1, t2, endwhilerevlen # branch to endwhile if char is '\0'
		addi t0, t0, 1 # increment total number of chars by 1
		b whilerevlen
	endwhilerevlen:
		addi t0, t0, -1 # decrement starting address by 1
		whilerev:
			add t2, t0, a0 # set t2 to the address of string[t0]
			li t3, -1 
			beq t0, t3, endrev # b to end if t0 is -1
			lb t2, 0(t2) # load the char at the address of string[t0]
			sb t2, 0(a1)
			addi t0, t0, -1 # decrement starting address by 1
			addi a1, a1, 1 # increment destination address by 1
			b whilerev
	endrev:
		li t1, '\0'
		sb t1, 0(a1)
		ret
	
strcat:
	whilecat1:
		li t1, '\0' # set t1 to the null char '\0'
		lb t2, 0(a0) # load the char at the address of string[t0]
		beq t2, t1, whilecat2 # branch to endloop if the char is '\0'
		sb t2, 0(a2) 
		addi a0, a0, 1 # increment starting address by 1
		addi a2, a2, 1 # increment destination address by 1
		b whilecat1
	whilecat2:
		lb t2, 0(a1) # load the char at the address of string[t0]
		beq t2, t1, endwhilecat # branch to endloop if the char is '\0'
		sb t2, 0(a2) 
		addi a1, a1, 1 # increment starting address by 1
		addi a2, a2, 1 # increment destination address by 1
		b whilecat2
	endwhilecat:
		li t1, '\0'
		sb t1, 0(a2)
		mv a0, t0
		ret
strmix:
	whilemix:
		li t1, '\0' # set t1 to the null char '\0'
		lb t2, 0(a0) # load the char at the address of first string[t0]
		beq t2, t1, endwhilemix # branch to endloop if the current char in first word is '\0'
		sb t2, 0(a2) 
		addi a0, a0, 1 # increment starting address of first word by 1
		addi a2, a2, 1 # increment destination address by 1
		lb t2, 0(a1) # load the char at the address of second string[t0]
		beq t2, t1, endwhilemix # branch to endloop if the current char in second word is '\0'
		sb t2, 0(a2) 
		addi a1, a1, 1 # increment starting address of second word by 1
		addi a2, a2, 1 # increment destination address by 1
		b whilemix
	endwhilemix: 
		lb t5, 0(a0) # load the char at the address of first string[t0]
		lb t6, 0(a1) # load the char at the address of second string[t0]
		bne t5, t1, moreinfirst # branch to moreinfirst if the char is '\0'
		bne t6, t1, moreinsecond # branch to moreinsecond if the char is '\0'
		b endmix
		moreinfirst:
			li t1, '\0' # set t1 to the null char '\0'
			lb t2, 0(a0) # load the char at the address of first string[t0]
			beq t2, t1, endmix # branch to endloop if the char is '\0'
			sb t2, 0(a2) 
			addi a0, a0, 1 # increment starting address by 1
			addi a2, a2, 1 # increment destination address by 1
			b moreinfirst
		moreinsecond:
			li t1, '\0' # set t1 to the null char '\0'
			lb t2, 0(a1) # load the char at the address of second string[t0]
			beq t2, t1, endmix # branch to endloop if the char is '\0'
			sb t2, 0(a2) 
			addi a1, a1, 1 # increment starting address by 1
			addi a2, a2, 1 # increment destination address by 1
			b moreinsecond
		
		endmix:
			li t1, '\0'
			sb t1, 0(a2)
			mv a0, t0
			ret

.data
saveds0: .word 0
savedra: .word 0
