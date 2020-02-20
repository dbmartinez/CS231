# Assignment 1 Description
# ======================
# Write a program in MIPS assembly language that asks the users to enter a value for array size
# “n” and fill up the array with n integers. Then reverse the array and print it on the screen.
# You are required to do the following in your program:
# 1) Create up to 80 bytes of space in your program
# 2) “n”, the array size, should be greater than zero and less than 20
# 3) Each element of the array should be positive and divisible by 3
# 4) Array should be reversed within itself. i.e. you must not create another array to place the elements in reverse order

.data
	arraySize: .space 80

	intro1: .asciiz "\t\t\tAssignment 1\n"
	intro2: .asciiz "\t\t\t____________\n"

	userInput1: .asciiz "\nInput a number for the size of array: "
	userInput2: .asciiz "\nInput number: "
	
	str1: .asciiz "===================="
	str2: .asciiz "\nInput for array size\n"
	
	error2: .asciiz "Your input is too high, must be less than 20.\n"
	error3: .asciiz "Your input is too low, must be greater than 0.\n"
	error4: .asciiz "Your input is not divisible by 3.\n"
	
	reversePrompt: .asciiz "Array in reverse order\n"
	str3: .asciiz "----------------------\n"
	newLine: .asciiz "\n"
    
.text

#MAIN...(intro)
main:

	li $v0, 4			# Load String
	la $a0, intro1			# Intro(Assignemnt1)
	syscall
	
	li $v0, 4			# Load String
	la $a0, intro2			# ______________
	syscall  
	
#BEGIN FUNCTION...  
Begin:

	la $s0, arraySize             	# Load array to $s0
    
        li $v0, 4			# Load string
        la $a0, userInput1            	# Display intro for user input
        syscall
            
        jal readNum               	# Jump and link to readNum function
        add $s1, $t0, $0        	# Store result in $s1
        
        add $a0, $s1, $0        	# Transfer input to $a0 to verify function
        jal verifySize              	# Jump and link to verifySize function
        
        add $t0, $v0, $0        	# Store result to $t0
        beq $0, $t0, Begin      	# If equal to zero, go back to begin
            
        add $a0, $s1, $0        	# If passes errors, array goes to $a0
        jal createArray                	# Call createArray function
            
        add $a0, $s1, $0        	# Call reverseArray function
        jal reverseArray
			
	add $a0, $s1, $0        	# Call printArray function
	jal printArray
			
	li $v0, 10			# Exit program
	syscall
			
#READNUM FUNCTION...
readNum:

	li $v0, 5              		# User inputs for array size
	syscall
	
	add $t0, $v0, $0		# Store $v0 to $t0
		
        jr $ra                 		# Return to Begin

#VERIFYSIZE FUNCTION...
verifySize:
	
	li  $s2, 20             	# Hardcode($s2) to 20 for max
        add $t0, $a0, $0        	# Store argument to $t0
        
        bge $t0, $s2, error1     	# Input greater than 20, ERROR
        ble $t0, $0, error0      	# Input less than 0, ERROR
        
        jr $ra                  	# Return to Begin

#CREATE ARRAY...
createArray:    

        li  $s3, 0              	# Hardcode to 0(counter)
        add $t1, $a0, $0        	# Send argument($a0) to max counter($t1)
        
        addi $sp, $sp, -4         	# Subtract 4 for new element in stack
        sw  $ra, 0($sp)         	# Store Begin in stack
        
        li $v0, 4			# Load string
	la $a0, newLine			# New line(\n)
	syscall
    
	la $a0, str1			# ==========
	syscall
	
	la $a0, str2			# Prompt(input array)
	syscall
	
	la $a0, str1			# ==========
	syscall
	
	la $a0, newLine			# New line(\n)
	syscall
        
making_array:   
	
	beq $s3, $t1, finish       	# If array is equal to 0, go to finish
    
        li $v0, 4			# Load string
        la $a0, userInput2           	# Display prompt to user
        syscall
            
        jal readNum               	# Jump and link to readNum function
            
        add $t2, $v0, $0        	# Store input($v0) to $t2
        add $a0, $t2, $0        	# Store input($t2) to $a0
        
        jal checkNumPositive     	# Jump and link to checkNumPositive function
            
        add $t3, $v0, $0        	# Save result from checkNumPositive into $t3
        beq $0, $t3, negativeNum     	# If equal to 0, then it's negative
            
        add $a0, $t2, $0        	# Add input to argument($a0)
        jal divisibleBy3              	# Jump and link to see if divisible by 3
        
        add $t3, $v0, $0        	# Save result from divisibleBy3 into $t3
        beq $0, $t3, notDivisibleBy3    # If result is zero, then it's not divisable by 3
            
       	sw $t2, 0($s0)         		# Store input into array
       	addi $s0, $s0, 4         	# Increase 4 bytes to move to next element
        addi $s3, $s3, 1         	# Counter by 1
            
        j making_array
            
finish:    

	lw $ra, 0($sp)         		# Load Begin to $ra
        addi $sp, $sp, 4         	# Add 4 to reset stack pointer
        
        jr $ra                 		# Return to Begin
            
#REVERSEARRAY FUNCTION...		
reverseArray:

	add $t5, $a0, $0        	# Load the array size into $t8 
	li $s3, 0			# Harcode to 0 (counter)
	li $s4, 2			# Hardcode 2 to $s6 for dividing
        li $s5, 4              		# Hardcode to 4 for multiplication
        
        la $s0, arraySize        	# Declare array(First index, head)
        
        mult $t5, $s5           	# Multiply array by 4
        mflo $t6                	# Offset from first element
		
	add $t2, $t6, $s0		# Last index of the array(tail)
	addi $t2, $t2, -4		# Subtract 4 bytes from the address
		
	div $t5, $s4			# Divide $t8 by 2
	mflo $t7			# Put result into $t9
                                
swap:   

	beq $t7, $s3, endSwap		# End if index are the same
            
        lw $t3, 0($s0)			# Store first elements
	lw $t4, 0($t2)			# Store last elements
			
	sw $t3, 0($t2)			# Perform swap
	sw $t4, 0($s0)			# Perform swap
			
	addi $s0, $s0, 4		# Increment by 4 bytes
	addi $t2, $t2, -4		# Decrement by 4 bytes
			
	addi $s3, $s3, 1		# Counter by 1
			
	j swap				# Jump back to swap
			
endSwap:

	jr $ra				# Return to Begin

#PRINTARRAY FUNCTION...
printArray:

	add $t0, $a0, $0		# Array size from Begin
	
	la $s0, arraySize		# Declare array
	li $s3, 0			# Hardcode to 0(loop counter)
		
	li $v0, 4			# Load string
	la $a0, newLine			# New line(\n)
	syscall
	
	la $a0, str3			# ----------------
	syscall
	
	la $a0, reversePrompt		# Display reverse prompt
	syscall
	
	la $a0, str3			# ----------------
	syscall

loop:	

	beq $t0, $s3, endloop    	# Array size($t0) = 0, go to endloop
			
	li $v0, 1
	lw $a0, 0($s0)			# Display array in reverse order
	syscall
			
	li $v0, 4			# Load string
	la $a0, newLine			# New line(\n)
	syscall
			
	addi $s0, $s0, 4		# Increment array by 4 bytes
	addi $s3, $s3, 1		# Increment by 1
			
	j loop				# Jump back to loop		
			
endloop:
		
	jr $ra				# Return to Begin
	
#DIVISIBLE BY 3...
divisibleBy3:
 
        add $s5, $a0, $0        	# Store argument in $s5
        li $s4, 3              		# Hardcode 3 to $t7 for dividing
       
        div $s5, $s4            	# Divide $t8(array) by 3
        
        mfhi $t6                	# Remainder($t6)
        
        bne $t6, $0, notDivisibleBy3    # Not divisible if not equal to zero
        
        jr $ra                 		# Return to last address
			
#CHECKNUMPOSITIVE FUNCTION...
checkNumPositive:  

        add $s6, $a0, $0       		# Store argument in $s6
        blt $s6, $0, negativeNum    	# Negative if less than zero
        
        jr $ra                 		# Return to last address

#ERRORS...  
error0:  

        li $v0, 4			# Load string
        la $a0, newLine			# New line(\n)
        syscall
        
        la $a0, error3          	# Error if less than 0
        syscall
            
        li $v0, 0              		# Return 0
        jr $ra                 		# Return to Begin
    
error1:  

        li $v0, 4			# Load string
        la $a0, newLine			# New line(\n)
        syscall
        
        la $a0, error2         		# Error if greater than 20
	syscall
            
        li $v0, 0              		# Return 0
        jr $ra                 		# Return to Begin
   
#ERRORS in array... 
negativeNum: 

        li $v0, 4               	# Load string
        la $a0, error3          	# Error if less than 0
        syscall
            
        j making_array                  # Jump back to making_array
            
notDivisibleBy3:  
 
        li $v0, 4			# Load string
        la $a0, error4         		# Error if not divisible by 3
        syscall
            
        j making_array                  # Jump back to making_array
