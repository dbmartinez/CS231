.data			 

	num: .float 27.5555 		# store 27.5555 foating value to 						#address indicated by num 	

.text			 
main:
	
	li $v0, 2			# code for printing float (single)
	l.s $f12, num		 	#load 27.5555 at address num into $f12 
	syscall				 #print the number

