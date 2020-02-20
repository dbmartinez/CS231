.data
	# Lab 2(Description/Author/Date)
	str1: .asciiz "Program Description:\tOutput\n"
	str2: .asciiz "Author:\t\t\tDaniel Martinez\n"
	str3: .asciiz "Creation Date:\t\t09/05/2018\n\n\n"
	
	# Company Name
	company: .asciiz "Here is the Report of Top 5 employees in Erickson Company:\n"
	line1: .asciiz "================================================================\n"
	
	# Employee Information
	header: .asciiz "\tLast Name\tFirst Name\tPosition\t\tSalary\n"
	whatevs: .asciiz "\t~~~~~~~~~\t~~~~~~~~~~\t~~~~~~~~\t\t~~~~~~\n"
	firstColumn: .asciiz "\tSmith\t\tAdam\t\tDirector\t\t"
	secondColumn: .asciiz "\n\tHadden\t\tMary\t\tDirector\t\t"
	thirdColumn: .asciiz "\n\tSimpson\t\tMike\t\tManager\t\t\t"
	fourthColumn: .asciiz "\n\tWilliams\tAndrea\t\tDesigner\t\t"
	fifthColumn: .asciiz "\n\tAmer\t\tAli\t\tDesigner\t\t"
	line2: .asciiz "\n===========================================================================\n"
	
.text
	# Display str1,str2,str3
	li $v0, 4
	la $a0, str1
	syscall
	
	la $a0, str2
	syscall
	
	la $a0, str3
	syscall
	
	# Company Name
	la $a0, company
	syscall
	
	la $a0, line1
	syscall
	
	# Display Employee Information
	la $a0, header
	syscall
	
	la $a0, whatevs
	syscall
	
	li $v0, 4
	la $a0, firstColumn
	syscall
	
	li $v0, 1
	li $a0, 99010
	syscall
	
	li $v0, 4
	la $a0, secondColumn
	syscall
	
	li $v0, 1
	li $a0, 95220
	syscall
	
	li $v0, 4
	la $a0, thirdColumn
	syscall
	
	li $v0, 1
	li $a0, 80000
	syscall
	
	li $v0, 4
	la $a0, fourthColumn
	syscall
	
	li $v0, 1
	li $a0, 70000
	syscall
	
	li $v0, 4
	la $a0, fifthColumn
	syscall
	
	li $v0, 1
	li $a0, 55000
	syscall
	
	li $v0, 4
	la $a0, line2
	syscall
	
	# Quit Program
	li $v0, 10
	syscall
	
