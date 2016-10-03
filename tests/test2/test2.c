#include <avr/io.h>

/*void a();
void b();
int c(char a, uint16_t b, int c);
*/
/*
	uint8_t i = 9;
	int j = c(i, 10, 11);
	j = i * 2;
*/
void b(){
	uint16_t i = 10;
	int j = 12;
	int k = c(1, i, j);
	k++;
}

int cc(char a, uint16_t b, int c){
	int x,y,z;
	x=a+c;
	y=c-a;
	z=x+y;
	return z;
}

void a(){
	cc(9,10,11);
}
int main(void){
	/*uint16_t i;
	i = 100;
	int j;	
	j=300;
	uint8_t s[8];*/
	a();
	b();
	while(1){}  
	//return 1;
}


