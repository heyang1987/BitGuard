/*
 * Copyright 2010
 *
 * The Dependable Systems Research Group
 * School of Computing
 * Clemson University
 *     
 *  author: Jason O. Hallstrom
 * version: 1.0.0
 *   since: 6/25/10
*/


#include "diagnostics.h"


// used to record system diagnostic information; the 
// diagnostic instances are globally accessible
core_diagnostics_t	core_diagnostics	= { 0 };
ow_diagnostics_t	ow_diagnostics		= { 0 };
sdi12_diagnostics_t	sdi12_diagnostics	= { 0 };
xbee_diagnostics_t	xbee_diagnostics	= { 0 };
gm862_diagnostics_t	gm862_diagnostics	= { 0 };

