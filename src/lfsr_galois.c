#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>


uint16_t doLFSR(uint16_t reg){
	
	unsigned lsb = reg & 1;   /* Get LSB (i.e., the output bit). */
	reg >>= 1;                /* Shift register */
	if (lsb)                   /* If the output bit is 1, apply toggle mask. */
		reg ^= 0xB400u;
	return reg;
}







int main(void) {
	uint16_t start_state = 0xACE1u;  /* Any nonzero start state will work. */
	uint16_t lfsr = start_state;
	unsigned period = 0;
	printf("%016"PRIx16":%016"PRIx16"\n", (lfsr>>8), (lfsr&0xffu));
	do {
		lfsr = doLFSR(lfsr);
// 		printf("%016"PRIx32":%016"PRIx32"\n", (lfsr>>8), (lfsr&0xffu));
		++period;
		
	} while (lfsr != start_state);
// 	} while(period < 5);
	printf("%016"PRIx16":%016"PRIx16"\n", (lfsr>>8), (lfsr&0xffu));
	printf("period = %d\n", period);
    return 0;
}