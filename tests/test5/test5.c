#include <avr/io.h>

int a(int i);

int main(void){
	uint32_t l;
	l = 243;
	uint8_t k;
	k = 32;	
	uint16_t i;
	i = 100;
	int j;	
	j = a(5);
	while(1){}   
}

int a(int i){
	if(i > 0){
		return ( i + a(--i) );
	} else {
	  return i;
	}
}

