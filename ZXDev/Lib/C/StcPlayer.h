#ifndef StcPlayer__h
#define StcPlayer__h

/**
 * 	Disable loop if this bit set
 */
#define STC_UNLOOP 0x01

/**
 * 	Is set each time, when loop point is passed
 */
#define STC_LOOP_FLAG 0x80

/**
 * 	StcFlags
 */
extern unsigned char StcPlayer_flags;

/**
 *	Init player
 */
extern void StcPlayer_Init (unsigned int mod) __z88dk_fastcall;

/**
 *	Play one quark (20 millisec).
 *	Its function must be called every 20ms
 *	for playing 
 */
void StcPlayer_Play (void);


#define StcPlayer__init()

#endif
