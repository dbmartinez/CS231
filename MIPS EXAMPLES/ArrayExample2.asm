.data
	myArray: .space 12
	
	newLine: .asciiz "\n"
	
.text
	addi $s0, $0, 4
	addi $s1, $0, 10
	addi $s2, $0, 12
	
	# Index = $t0, starts at zero(0)
	addi $t0, $0, 0
	
	sw $s0, myArray($t0)		# Save 4 to $t0 in array
	addi $t0, $t0, 4		# Increase by 4 bytes
	
	sw $s1, myArray($t0)		# Save 10 to $t0 in array
	addi $t0, $t0, 4		# Increase by 4 bytes
	
	sw $s2, myArray($t0)		# Save 12 to $t0 in array
	
	lw $t6, myArray($0)		
	
	li $v0, 1
	addi $a0, $t6, 0		# Display final result
	syscall