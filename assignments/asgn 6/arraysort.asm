# Megan Robinson
.globl swap 
.globl selectionSort
 
#void selectionSort(int arr[], int i, int n){
# a0 = sp, points to the start of the array
# a1 = index of the current minimum
# a2 = size of the array
selectionSort:
# callee setup goes here

    # /* find the minimum element in the unsorted subarray `[i…n-1]`
    # // and swap it with `arr[i]`  */
#    int j;
	addi sp, sp, -16
	sw ra, 12(sp) # store return address onto the stack
	li t0, 0 # t0 = j = the current index
#    int min = i;
	mv t1, a1 # t1 = i = the index of the current minimum (the number you're comparing the rest to)

#    for (j = i + 1; j < n; j++)    {

for:
#j = i + 1;
	addi t0, a1, 1 # make the index, j, start at one more than i (the minimum)

forloop:
# j < n
	bge t0, a2, endfor # if current index (j) is >= size of array, branch to endfor

#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j] < arr[min]) {
if1:
#            min = j;    /* update the index of minimum element */
	
	
	slli t3, t0, 2 # t3 = offset of j
	add t3, a0, t3 # t3 = address of j
	lw t3, 0(t3) # t3 = element at index j
	slli t4, t1, 2 # t4 = offset of current min
	add t4, a0, t4 # t4 = address of current min
	lw t4, 0(t4) # t4 = element at index of current minimum
	
	bge t3, t4, endif1 # if the element at j is >= the element at the current minimum, branch to endif1
  	mv t1, t0 # if the number at index j is less than the current minimum, then j is the index of the new minimum

#        }
endif1:
	addi t0, t0, 1 # increment j by 1
	j forloop # branch to forloop

#    }
endfor:
 
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#    swap(arr, min, i);
#caller setup and subroutine call for swap goes here.
	addi sp, sp, -16
	sw a0, 12(sp) # put current sp onto stack
	sw a1, 8(sp) # put current i onto stack
	sw a2, 4(sp) # put current size onto stack

	mv a0, a0 # a0 = sp
	mv a1, a1 # a1 = index of i
	mv a2, t1 # a2 = the new minimum
	jal swap # call swap function

#caller teardown for swap goes here (if needed).
	lw a0, 12(sp) # restore sp
	lw a1, 8(sp) # restore i
	lw a2, 4(sp) # restore size
	addi sp, sp, 16
  	
#    if (i + 1 < n) {
if2:
	
#        selectionSort(arr, i + 1, n);
#caller setup and subroutine call for selectionSort goes here.
	addi a1, a1, 1
	bge a1, a2, endif2 # branches to endif2 if i + 1 >= n (n is the size of the array)
	jal selectionSort

#caller teardown for selectionSort goes here (if needed).

#    }
endif2:
# callee teardown goes here
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

#}
#/* Utility function to swap values at two indices in an array*/
#void swap(int arr[], int i, int j) {
swap: 
# swap callee setup goes here
	
	slli t3, a1, 2 # t3 = offset of i
	add t3, a0, t3 # t3 = address of i
	lw t5, 0(t3) # t5 = element at index i
	
	slli t4, a2, 2 # t4 = offset of new min
	add t4, a0, t4 # t4 = address of new min
	lw t6, 0(t4) # t6 = element at index of new minimum
	
	sw t5, 0(t4) # swap elements
	sw t6, 0(t3)
	ret

#    int temp = arr[i];


#    arr[i] = arr[j];


#    arr[j] = temp;


# swap callee teardown goes here



#}
