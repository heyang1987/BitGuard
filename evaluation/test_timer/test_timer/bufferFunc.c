#include "bufferFunc.h"



void bufcpy(Buffer *buffer1,Buffer *buffer2){
	int i;
	for (i=0;i<buffer2->count;i++){
		buffer1->buffer[i] = buffer2->buffer[i];	
	}
	buffer1->count = buffer2->count;
}


void bufcat(Buffer *buffer1,Buffer *buffer2){
	int i;
	for (i=0;i<buffer2->count;i++){
		buffer1->buffer[buffer1->count+i] = buffer2->buffer[i];
	}
	buffer1->count += buffer2->count;
}