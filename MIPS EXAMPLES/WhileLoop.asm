.data
	str: .asciiz "\n Hello World"
	
.text
main:
	li $s1, 0
	li $s2, 12
	
loopDecision:
	beq $s1, $s2, exit
	
	li $v0, 4
	la $a0, str
	syscall
	
	addi $s1, $s1, 1
	
	j loopDecision
	
	Loop:
		beq	$t1, $t2, done
		lw	$s1, 0(($t0)
		add	$s0, $s1, $s0
		addi	$t1, $t1, 1
		j	Loop
exit:

	
exit:
	li $v0, 10
	syscall
