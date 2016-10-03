#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define SIZE 15000

int main() {
	int i = SIZE;
	srand(time(NULL));
	int number;
	FILE *fp;
	if( (fp = fopen("progmem1.h","w+"))!=NULL){
		fprintf(fp, "const int mydata[");
		fprintf(fp, "%d", SIZE);
		fprintf(fp, "] PROGMEM = {");
		while(i>0){
			number = rand()%201;
			fprintf(fp, "%d", number);
			if(i!=1){
				fprintf(fp, ", ");
			}
			i--;
		}
		fprintf(fp, "};");
	}
}
