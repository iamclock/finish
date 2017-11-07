#include <inttypes.h>
#include <stdio.h>

#define TAP_MASK_LOW64 0x0
#define TAP_MASK_HIGH64 0x28000005

// source: https://habrahabr.ru/post/140095/

do_lfsr(uint64_t *p){
	uint64_t low  = p[0] & TAP_MASK_LOW64;
	uint64_t high = p[1] & TAP_MASK_HIGH64;

	uint64_t s1 = low ^ high;
	//printf("%016"PRIx64"\n", s1);
	uint32_t s2 = (uint32_t)s1 ^ (uint32_t)(s1 >> 32);
	uint32_t s3 = (s2 & 0xffff) ^ (s2 >> 16);
	uint32_t s4 = (s3 & 0xff) ^ (s3 >> 8);
	uint32_t s5 = (s4 & 0xf) ^ (s4 >> 4);
	uint32_t s6 = (s5 & 0x3) ^ (s5 >> 2);
	uint32_t s7 = (s6 & 0x1) ^ (s6 >> 1);
	p[1] = (p[1] << 1) | (p[0] >> 63);
	p[0] = (p[0] << 1) | s7;
	//printf("%016"PRIx64":%016"PRIx64"\n", p[1], p[0]);
}

int main(){
	uint64_t lfsr_data[2] = {
		0xffffffffffffffffull,
		0xffffffffffffffffull,
	};
	volatile unsigned i;

	for(i = 0; i < 64/*0xffff * 32*/; ++i){
		//printf("%d ", i);
		do_lfsr(lfsr_data);
		printf("%016"PRIx64":%016"PRIx64"\n", lfsr_data[1], lfsr_data[0]);
	}
	printf("%016"PRIx64":%016"PRIx64"\n", lfsr_data[1], lfsr_data[0]);
}
