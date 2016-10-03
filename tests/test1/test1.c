#include <avr/io.h>

int a();
int b();
int c(char a, uint16_t b, int c);

int main(void){
	uint32_t l;
	l = 243;
	uint8_t k;
	k = 32;	
	uint16_t i;
	i = 100;
	int j;	
	j=300;
  int result = a();
  result++;
	while(1){}   
}

int a(){
	int i = 9;
	i = b();
	return i;
}

int b(){
	uint16_t i = 10;
	int j = 12;
	int k = c(1, i, j);
	k++;
	return k;
}

int c(char a, uint16_t b, int c){
	int x,y,z;
	x=a+c;
	y=c-a;
	z=x+y;
	return z;
}
