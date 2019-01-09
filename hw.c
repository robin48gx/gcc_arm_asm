#include <stdio.h>

volatile short int array_to_bit_reverse [16] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};

int main (int argc, char ** argv) {
int i,j,k;
	extern asm_main();
	asm_main();

	extern bit_reverse();
	for(i=0;i<16;i++)
		printf(" %i 0x%X  ",i,array_to_bit_reverse[i]);
	printf("\n");
	printf(" sizeof(short int) is %d  value atbr[0]=%d atbr[15]=%d about to bit reverse\n", sizeof(short int), array_to_bit_reverse[0], array_to_bit_reverse[15]);
	
	bit_reverse(array_to_bit_reverse,16);

	printf(" sizeof(short int) is %d  value atbr[0]=%d atbr[15]=%d\n", sizeof(short int), array_to_bit_reverse[0], array_to_bit_reverse[15]);
	for(i=0;i<16;i++)
		printf(" %i 0x%X  ",i,array_to_bit_reverse[i]);
	printf("\n");
	return 0;
	
}
