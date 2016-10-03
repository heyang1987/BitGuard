#include <avr/io.h>

int a(int i, int j, int k);
int main(void){
	uint32_t l;
	l = 243;
	uint8_t k;
	k = 32;	
	uint16_t i;
	i = 100;
	int j;	
	j=300;
  	int result = a(l,k,i);
	while(1){}   
}

int a(int i, int j, int k){
	return i+j+k;
}
