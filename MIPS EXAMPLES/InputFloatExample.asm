# This program will get the floating point number (single) from user and print it on the 
#screen. to get the number, by looking at system call table, we need to put the value of 
#6 into $v0  and then syscall will allow user to enter the value to $f0. and following 
#last example we can print the value.

	

.data			 	

.text			 
main:

	li $v0, 6			# code for getting float (single) from user
	syscall				# the entered value goes to $f0 after syscall					

	li $v0, 2			# code for printing float (single)  	
	mov.s $f12, $f0			# move that value that user entered from 					
					#$f0 to$f12 to get printed	
	syscall	
