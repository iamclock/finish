build_lfsrl:
	./translator.py lfsr.l
	./ltc lfsr_.l
build_lfsrc:
	gcc -O0 -o lfsr lfsr.c
build_lfsrc_dbg:
	gcc -ggdb -g3 -O0 -o lfsr lfsr.c


lfsrl: lfsrl
	rm lfsr_.l lfsr_.s
lfsrc: lfsrc
	./lfsr
runl: build_lfsrl
	./lfsrl_
clean:
	rm lfsr_.s lfsr_.o
