#include <inttypes.h>
#include <stdio.h>

#define TAP_MASK_LOW64 0x0
#define TAP_MASK_HIGH64 0x28000005

// source: https://habrahabr.ru/post/140095/

do_lfsr(uint64_t *p){
	uint64_t low  = p[0] & TAP_MASK_LOW64;
	uint64_t high = p[1] & TAP_MASK_HIGH64;
// 	printf("%016"PRIx64"%016"PRIx64"\n", p[1], p[0]);
// 	printf("%016"PRIx64"%016"PRIx64"\n", TAP_MASK_HIGH64, TAP_MASK_LOW64);
// 	printf("low: %016"PRIx64" high: %016"PRIx64"\n", low, high);
	
	uint64_t s1 = low ^ high;
	//printf("%016"PRIx64"\n", s1);
	uint32_t s2 = (uint32_t)s1 ^ (uint32_t)(s1 >> 32);
	uint32_t s3 = (s2 & 0xffff) ^ (s2 >> 16);
	uint32_t s4 = (s3 & 0xff) ^ (s3 >> 8);
	uint32_t s5 = (s4 & 0xf) ^ (s4 >> 4);
	uint32_t s6 = (s5 & 0x3) ^ (s5 >> 2);
	uint32_t s7 = (s6 & 0x1) ^ (s6 >> 1);
// 	printf("s1 = %016"PRIx64"\n", s1);
// 	printf("s2 = %d\n", s2);
// 	printf("s3 = %d\n", s3);
// 	printf("s4 = %d\n", s4);
// 	printf("s5 = %d\n", s5);
// 	printf("s6 = %d\n", s6);
// 	printf("s7 = %d\n", s7);
	p[1] = (p[1] << 1) | (p[0] >> 63);
	p[0] = (p[0] << 1) | s7;
	//printf("%016"PRIx64":%016"PRIx64"\n", p[1], p[0]);
}

int main(){
	uint64_t lfsr_data[2] = {
		0xffffffffffffffffull,
		0xffffffffffffffffull,
	};
	uint64_t lfsr_begin[2] = {
		0xffffffffffffffffull,
		0xffffffffffffffffull,
	};
	uint64_t index = 0;
	uint64_t count = 0;
	volatile unsigned i;
	do_lfsr(lfsr_data);
// 	for(i = 0; i < 0xffff * 32; ++i){
	while( (lfsr_data[0] != lfsr_begin[0]) || (lfsr_data[1] != lfsr_begin[1]) ){
		//printf("%d ", i);
// 		printf("%d ", index);
		if(index == 0xffffffffffffffffull){
			++count;
			printf("%lu ", count);
		}
		do_lfsr(lfsr_data);
		++index;
// 		printf("%016"PRIx64":%016"PRIx64"\n", lfsr_data[1], lfsr_data[0]);
	}
	printf("index: %lu\n", index);
	printf("count: %lu\n", count);
	printf("%016"PRIx64":%016"PRIx64"\n", lfsr_data[1], lfsr_data[0]);
}
