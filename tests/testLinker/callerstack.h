#ifndef __CALLER_STACK_H__
#define __CALLER_STACK_H__

uint16_t s __attribute__ ((section (".snapshotSP"))) = 3;
uint16_t t  __attribute__ ((section (".snapshotSP"))) = 3;
uint32_t bbb __attribute__ ((section (".snapshot"))) = 66;

#endif

