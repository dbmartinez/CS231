# Author: Daniel Martinez
# Due Date: 10/01/2018
# Prof: S. Mosleh

.data
	num: .float 1.8

	str: .asciiz "\nPlease input a temperature in Celsius: "
	str1: .asciiz "\nThe temperature in Fahrenheit is: "
	newLine: .asciiz "\n"
	
.text

main:

	li $v0, 4
	la $a0, str			# Display prompt to user
	syscall
	
	li $v0, 5			# User input(integer)
	syscall
	
	add $s0, $v0, $0		# Store $v0 to $s0
	
	li $t0, 32			# Hardcode to 32
	
	mtc1 $t0, $f1			# Move $t0 to floating point $f1
	cvt.s.w $f1, $f1		# Convert integer to single floating point 
	
	mtc1 $s0, $f2			# Move $s0 to floating point $f2
	cvt.s.w $f2, $f2		# Convert integer to single floating point 
	
	l.s $f3, num			# Load num(1.8) to $f3
	
	mul.s $f4, $f2, $f3		# Multiply user input($f2) by 1.8($f3)
	add.s $f5, $f4, $f1		# Add $f by $f1(32) to get fahrenheit
	
	li $v0, 4
	la $a0, str1			# Display final prompt to user
	syscall
	
	li $v0, 2
	mov.s $f12, $f5			# Display final result(float)
	syscall
	
	li $v0, 4
	la $a0, newLine			# New line
	syscall
	
	li $v0, 10			# Exit program
	syscall
	