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
*/


#ifndef DELAY_H
#define DELAY_H


#define NO_OP() asm volatile("nop" "\n\t")


// used to execute a specified number of no-ops;
// timing: 
//	no_ops(0) = 2us; 
//		otherwise, no_ops(x) = 2.1us + 1.1us * x
// note: interrupts will violate timing
void no_ops(uint32_t count);

// used to perform a blocking wait for the specified number 
// of milliseconds
// timing: 
//	delay_ms(0) = 3.6us;
//		otherwise, delay_ms(x) = 1000us * x + 3.7us
// note: interrupts will violate timing
void delay_ms(uint32_t count);


#endif
