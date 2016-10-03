test1.c:
	main->A->B->C

test2.c:
	main->A->C
	   |     
	   |->B->C

test3.c:
	main->A
	  I1
	  I2

test4.c:
	main->A
 	  I1
	  I2->B


test5.c:
	main->A(recursive)