.data

space:    .asciiz "\n"

.text
main:

	li $s1, 20	
	li $s2, 30
	
	mul $t1, $s1, $s2   	# Or user mul and use 3 registers
				
	#mult $s1, $s2		#multiply $s1 by $s2 and place the results
				#into lo and hi
				
	#mfhi	$t0		#move the value of hi register into $t0 
	#mflo	$t1		#move the value of lo register into $t1

	li $v0, 1
	add $a0, $t1, $0
	syscall

	li $v0, 10
	syscall


