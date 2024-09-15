# Megan Robinson
.globl swap
.globl selectionSort
.globl printArray

#struct def'n for reference
#struct studentNode {
#   char name[6]; 6 bytes
#   int studentid; 4 bytes
#   int coursenum; 4 bytes
#};
# total amount of bytes for each node is 14
 
#/* Recursive function to perform selection sort on subarray `arr[i…n-1]` */
#void selectionSort(studentNode arr[], int i, int n) {

# a0 = address of studentlist in the main program
# a1 = index of the current minimum
# a2 = size of the array
selectionSort:
#callee setup goes here
    
#    /* find the minimum element in the unsorted subarray `[i…n-1]`
#    // and swap it with `arr[i]`  */
#    int j;
	addi sp, sp, -16
	sw ra, 12(sp) # store return address onto the stack
	li t0, 0 # t0 = j = the current index
#    int min = i;
	mv t1, a1 # t1 = i = the index of the current minimum (the number you're comparing the rest to)
	
#    for (j = i + 1; j < n; j++)    {
for1:
	addi t0, a1, 1 # make the index, j, start at one more than i (the minimum)

forloop1:
	bge t0, a2, endfor1 # if current index (j) is >= size of array, branch to endfor1
#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j].studentid < arr[min].studentid) {
if1:
#            min = j;    /* update the index of minimum element */
	
	li t2, 16 # t2 = the offset of each element, this gets multiplied by the index
	
	mul t3, t0, t2
	addi t3, t3, 8 # t3 = offset of j to get to the studentid
	add t3, a0, t3 # t3 = address of j
	lw t3, 0(t3) # t3 = element at index j
	
	mul t4, t1, t2
	addi t4, t4, 8 # t4 = offset of current min to get to the studentid
	add t4, a0, t4 # t4 = address of current min
	lw t4, 0(t4) # t4 = element at index of current minimum
	
	bge t3, t4, endif1 # if the element at j is >= the element at the current minimum, branch to endif1
  	mv t1, t0 # if the number at index j is less than the current minimum, then j is the index of the new minimum

#        }
endif1:
	addi t0, t0, 1 # increment j by 1
	j forloop1 # branch to forloop1

endfor1:
#    }
 
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#caller setup goes here
	addi sp, sp, -16
	sw a0, 12(sp) # put current sp onto stack
	sw a1, 8(sp) # put current i onto stack
	sw a2, 4(sp) # put current size onto stack
	
#    swap(arr, min, i);
	mv a0, a0 # a0 = sp
	mv a1, a1 # a1 = index of i
	mv a2, t1 # a2 = the new minimum
	jal swap # call swap function

#caller teardown goes here (if needed)
	lw a0, 12(sp) # restore sp
	lw a1, 8(sp) # restore i
	lw a2, 4(sp) # restore size
	addi sp, sp, 16
 
#    if (i + 1 < n) {
if2:

#caller setup goes here

#        selectionSort(arr, i + 1, n);
	addi a1, a1, 1
	bge a1, a2, endif2 # branches to endif2 if i + 1 >= n (n is the size of the array)
	jal selectionSort
#caller teardown goes here (if needed)


#    }
endif2:
    	lw ra, 12(sp)
	addi sp, sp, 16
	ret
#callee teardown goes here (if needed)


#}
 
#/* Function to print `n` elements of array `arr` */ 
#void printArray(studentNode arr[], int n) { 

# a0 = address of the first element in the array
# a1 = size of the array (number of nodes in the array)
printArray:
#callee setup goes here
	addi sp, sp, -16
        sw ra, 12(sp)
        sw s0, 8(sp) # save whatever was in the s registers so that we can use them
        sw s1, 4(sp)
        sw s2, 0(sp)
        mv s0, a0 # s0 = address of the first element in the array
        mv s1, a1 # s1 = size of the array
#    int i;

#    for (i = 0; i < n; i++) {
for2:
	li s2, 0 # s2 = index of current node

forloop2:
	bge s2, s1 endfor2 # if current index (i) is >= size of array, branch to endfor1
	
#use ecalls to implement printf

	li t2, 16 # t2 = the offset of each element, this gets multiplied by the index
	
#        printf("%d ", arr[i].studentid);
	mul t3, s2, t2
	addi t3, t3, 8 # t3 = offset of i to get to the studentid
	add t3, s0, t3 # t3 = address of i
	lw a0, 0(t3) # t3 = element at index of current minimum
	
	li a7, 1
	ecall # print studentid
	
	# print a space
	li a0, 0x20
        li a7, 11
        ecall

#        printf("%s ", arr[i].name);
	li t2, 16 # t2 = the offset of each element, this gets multiplied by the index

	mul t3, s2, t2
	add a0, s0, t3 # t3 = address of i
	
	li a7, 4
	ecall # print name
	
	# print a space
	li a0, 0x20
        li a7, 11
        ecall
        
#        printf("%d\n", arr[i].coursenum);
	li t2, 16 # t2 = the offset of each element, this gets multiplied by the index

	mul t3, s2, t2
	addi t3, t3, 12 # t3 = offset of i to get to the coursenum
	add t3, s0, t3 # t3 = address of i
	lw a0, 0(t3) # t3 = element at index of current minimum
	
	li a7, 1
	ecall # print coursenum
	
	# print a space
	li a0, 0x20
        li a7, 11
        ecall
        
        #finish with a newline
        li a0, '\n'
        li a7, 11
        ecall
#    }
	addi    s2, s2, 1  # increment i
        b       forloop2
endfor2:
#caller teardown goes here
	lw ra, 12(sp)
        lw s0, 8(sp)
        lw s1, 4(sp)
        lw s2, 0(sp)
        addi sp, sp, 16
        ret
#}
 
 

#/* Utility function to swap values at two indices in an array*/
#void swap(studentNode arr[], int i, int j) {
swap:
#caller setup goes here

#    studentNode temp = arr[i];


#    arr[i] = arr[j];


#    arr[j] = temp;
	li t2, 16 # t2 = the offset of each element, this gets multiplied by the index
	
	# swap name
	mul t3, a1, t2 # t3 = offset of i
	add t3, a0, t3 # t3 = address of i
	lw t5, 0(t3) # t5 = element at index i
	
	mul t4, a2, t2 # t4 = offset of new min
	add t4, a0, t4 # t4 = address of new min
	lw t6, 0(t4) # t6 = element at index of new min
	
	sw t5, 0(t4) # swap elements
	sw t6, 0(t3)
	
	# swap studentid
	mul t3, a1, t2 # t3 = offset of i
	addi t3, t3, 8 # t3 = offset of i to get to i's studentid
	add t3, a0, t3 # t3 = address of i
	lw t5, 0(t3) # t5 = element at index i
	
	mul t4, a2, t2 # t4 = offset of new min
	addi t4, t4, 8 # t3 = offset of new min to get to new min's studentid
	add t4, a0, t4 # t4 = address of new min
	lw t6, 0(t4) # t6 = element at index of new min
	
	sw t5, 0(t4) # swap elements
	sw t6, 0(t3)
	
	# swap coursenum
	mul t3, a1, t2 # t3 = offset of i
	addi t3, t3, 12 # t3 = offset of i to get to i's coursenum
	add t3, a0, t3 # t3 = address of i
	lw t5, 0(t3) # t5 = element at index i
	
	mul t4, a2, t2 # t4 = offset of new min
	addi t4, t4, 12 # t3 = offset of new min to get to new min's coursenum
	add t4, a0, t4 # t4 = address of new min
	lw t6, 0(t4) # t6 = element at index of new min
	
	sw t5, 0(t4) # swap elements
	sw t6, 0(t3)
	
	ret
#caller teardown goes here


#}
