/*
 * test3.c
 *
 * Created: 9/10/2013 6:02:29 PM
 *  Author: jonas
 */ 


#include <avr/io.h>

int main(void)
{
	asm volatile(
	"out __SREG__,r0"	"\n\r"
	"out __SP_H__,r29"
	);
	int i = 0;
	i = i + 3;

	int j = 3;
	j = i + j;
    while(1)
    {
        //TODO:: Please write your application code 
    }
}