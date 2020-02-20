.data
	Array: .word 0,0,0,0,0,0,0,0,0,0
	
	str: .asciiz "\nEnter the number of elements: "
	
	content: .asciiz "\n==============="
	str1: .asciiz "\nEnter number: "
	
	content1: .asciiz "\n=========================================="
	str2: .asciiz "\nThe content of array in reverse order is: "
	content2: .asciiz "\n==========================================\n"
	
	error1: .asciiz "\nError, should not be a negative number\n"
	error2: .asciiz "\nError array cannot have more than 10 elements, try again!!\n"
	newLine: .asciiz"\n"

.text
main:
	li $t0, 0		# Load $t0 to 0(size of elements)
	li $t1, 10		# Load $t1 to 10(size of elements)
	la $s0, Array		# Load $s0 to array
	
	li $v0, 4		# Ask user how many elements for array
	la $a0, str
	syscall
		
	li $v0, 5		# User enters a number
	syscall
	
	add $s6, $v0, $0	# Store $v0 to $s6
	
	blt $s6, $t0, error0
	bgt $s6, $t1, error	# Check to see if value is greater than 10
	
	li $v0, 4
	la $a0, content		# =======================
	syscall
	
loop:	
	beq $t0, $s6, next
	
	li $v0, 4		# Display prompt
	la $a0, str1
	syscall
	
	li $v0, 5		# User input
	syscall
	
	sw $v0, 0($s0)		# address of first element of array
	
	addi $t0, $t0, 1	# Increment by 1
	addi $s0, $s0, 4	# Add 4 to next section
	
	j loop			# Jump back
	
next:
	li $t0, 0		# Load $t0 to 0(size of elements)
	li $t1, 10		# Load $t1 to 10(size of elements)
	
done:
	beq $t0, $s6, done
	
	li $v0, 4		# Display prompt
	la $a0, content1	# ==============
	syscall
	
	la $a0, str2		# Reverse order
	syscall
	
	la $a0, content2	# =============
	syscall
		
	loop2:				# Move loop2 here
		add $s0, $s0, -4	# Decrement by 4 bytes

		lw $t2, 0($s0)		# Load word $t2 into array $s0
		addi $t0, $t0, 1	# Increment by 1
		
		beq $t2, $0, exit 	# When number reaches zero terminate
	
		li $v0, 1		
		add $a0, $t2, $0	# Display integers
		syscall
	
		li $v0, 4
		la $a0, newLine		# New line
		syscall
	
		addi $t0, $t0, -1	# Decrement by 1
	
		j loop2			# Jump back up
	
exit:
	li $v0, 10		# Terminate program
	syscall

error0:
	li $v0, 4		# Display error message
	la $a0, error1
	syscall
	
	j main			# Jump back to main to have user re-enter a number
	
error:
	li $v0, 4		# Display error message
	la $a0, error2
	syscall
	
	j main			# Jump back to main to have user re-enter a number
