#ifndef  _BUFFER_FUNC_H
#define  _BUFFER_FUNC_H

#include <avr/io.h>

typedef struct {
	uint8_t* buffer;
	uint8_t count;
}Buffer;


void bufcpy(Buffer *buffer1,Buffer *buffer2);

void bufcat(Buffer *buffer1,Buffer *buffer2);
	
#endif