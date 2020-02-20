.data
	array: .space 40
	
	str: .asciiz "Enter a number: "

	str1: .asciiz "\nLargest element in array: "
	
	newLine: .asciiz "\n"
.text

main:

	li $t0, 0 			# i = 0
	li $t1, 10 			# Read 10 integers
	la $t2, array 			# $t2 points to address of array
	
	li $v0, 4
	la $a0, newLine			# New line(\n)
	syscall

loop:
	
	li $v0, 4
	la $a0, str			# Display prompt
	syscall

	li $v0, 5 			# User input
	syscall

	add $t4, $t0, $t0
	add $t4, $t4, $t4
	add $t4, $t4, $t2 		# address of array[i] = address of array[0] + 4 * i because each integer is 4 byte
	
	sw $v0, 0($t4) 			# Store i integer in array[i]
	
	addi $t0, $t0, 1 		# i = i + 1
	
	blt $t0, $t1, loop		# If (i < 10) then go to the loop
					# ($t0 = 0, $t1 = 10)
	la $a0, array 			# a0 = address of array
	addi $a1, $0, 9 		# $a1 = n = 9
					#$t0 has min, $t1 has max
					#initialise $t0 & $t1 with array[0]
	lw $t0, 0($a0)
	lw $t1, 0($a0)
	addi $a0, $a0, 4		# move to array[1]
  
loop1:   

	lw $t2, 0($a0)
	blt $t2, $t0, changemin
	
returnmin:

	bgt $t2, $t1, changemax
	
returnmax:

	addi $a1, $a1, -1
	addi $a0, $a0, 4 		# move to array[1]
	bne $a1, $0, loop1
  
	li $v0, 4
	la $a0, str1
	syscall

	li $v0, 1 			# Read an integer
	add $a0, $t1, $0
	syscall

	li $v0, 10			# Exit program
	syscall

changemin:

	add $t0, $t2, $0
	
	j returnmin

changemax:

	add $t1, $t2, $0
	
	j returnmax
