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


#ifndef DIAGNOSTICS_H
#define DIAGNOSTICS_H


#include <stdint.h>


//---
// diagnostic types
//---

// used to record core system diagnostic information
typedef struct {
	// the number of errors encountered while attempting
	// to schedule new tasks
	uint32_t scheduling_errors;
} core_diagnostics_t;

// used to record 1-wire diagnostic information
typedef struct {
	// the number of search errors encountered while
	// enumerating the devices on the 1-wire bus
	uint32_t ow_search_errors;

	// the number of errors encountered while requesting
	// parallel temperature conversion on the 1-wire bus
	uint32_t ow_conversion_errors;

	// the number of errors encountered while collecting
	// temperature data from the devices on the 1-wire bus
	uint32_t ow_collection_errors;
} ow_diagnostics_t;

// used to record sdi-12 diagnostic information
typedef struct {
	// the number of device activation errors encountered
	// while attempting to wake the sdi-12 bus
	uint32_t sdi12_activation_errors;

	// the number of errors encountered while requesting
	// parallel conversion on the sdi-12 bus
	uint32_t sdi12_conversion_errors;

	// the number of errors encountered while collecting
	// data from the devices on the sdi-12 bus
	uint32_t sdi12_collection_errors;
} sdi12_diagnostics_t;

// used to record xbee diagnostic information
typedef struct {
	// the number of errors encountered while trying
	// to wake the xbee radio
	uint32_t xbee_wake_errors;

	// the number of errors encountered while submitting
	// xbee commands
	uint32_t xbee_cmd_errors;

	// the number of errors encountered while attempting
	// to send a message
	uint32_t xbee_send_errors;

	// the number of errors encountered while attempting
	// to receive an xbee API frame
	uint32_t xbee_frame_errors;
} xbee_diagnostics_t;

// used to record gm862 diagnostic information
typedef struct {
	// the number of errors encountered while trying 
	// to wake the gm862
	uint32_t gm862_wake_errors;
	
	// the number of errors encountered while trying
	// to put the gm862 to sleep
	uint32_t gm862_sleep_errors;
	
	// the number of errors encountered while trying
	// to set the gm862 profile
	uint32_t gm862_set_profile_errors;
	
	// the number of gsm registration checks that failed
	uint32_t gm862_gsm_registration_errors;
	
	// the number of gprs registration checks that failed
	uint32_t gm862_gprs_registration_errors;
	
	// the number of errors encountered while trying to
	// acquire the cell signal strength
	uint32_t gm862_rssi_errors;
	
	// the number of errors encountered while trying to
	// acquire the current time
	uint32_t gm862_time_errors;
	
	// the number of errors encountered while trying to
	// start / end an sms message
	uint32_t gm862_sms_start_errors;
	uint32_t gm862_sms_end_errors;
	
	// the number of errors encountered while trying to
	// acquire/drop an ip address
	uint32_t gm862_get_ip_errors;
	uint32_t gm862_drop_ip_errors;
	
	// the number of errors encountered while trying to
	// start / end an email message
	uint32_t gm862_email_start_errors;
	uint32_t gm862_email_end_errors;
	
	// the number of errors encountered while trying to
	// connect/disconnect to/from a tcp endpoint
	uint32_t gm862_tcp_connect_errors;
	uint32_t gm862_tcp_disconnect_errors;
	
	// the number of errors encountered while trying to
	// escape into command mode
	uint32_t gm862_escape_errors;
} gm862_diagnostics_t;

//---


//---
// diagnostic references
//---

// a single instance of each diagnostic type is declared in 
// diagnostics.c; these statements make the instances globally
// accessible
extern core_diagnostics_t	core_diagnostics;
extern ow_diagnostics_t		ow_diagnostics;
extern sdi12_diagnostics_t	sdi12_diagnostics;
extern xbee_diagnostics_t	xbee_diagnostics;
extern gm862_diagnostics_t	gm862_diagnostics;

//---


#endif
