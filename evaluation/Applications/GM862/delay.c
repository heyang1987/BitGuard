/*
 * Copyright 2010
 *
 * The Dependable Systems Research Group
 * School of Computing
 * Clemson University
 *     
 *  author: Jason O. Hallstrom
 * version: 1.0.0
 *   since: 2/25/10
 *
 *    note: This code should, at some point, be rewritten
 *          in assembly to improve the accuracy.
*/


#include <stdint.h>
#include <stdbool.h>
#include "delay.h"


// used to execute a specified number of no-ops;
// timing:
//	no_ops(0) = 2us;
//		otherwise, no_ops(x) = 2.1us + 1.1us * x
// note: interrupts will violate timing
void __attribute__((noinline)) no_ops(uint32_t count) {
	while(count--) { 
		NO_OP();
	}
}

// used to perform a blocking wait for the specified number 
// of milliseconds
// timing: 
//	delay_ms(0) = 3.6us;
//		otherwise, delay_ms(x) = 1000us * x + 3.7us
// note: interrupts will violate timing
void __attribute__((noinline)) delay_ms(uint32_t count) {
	
	// timing information derived using a cycle-accurate 
	// simulator
	while(count--) {
		no_ops(906);
		NO_OP();
		NO_OP();
	}
}

