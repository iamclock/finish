build_lfsrl:
	./translator.py lfsr.l
	./ltc lfsr_.l
build_lfsrc:
	gcc -O0 -o lfsr lfsr.c
build_lfsrc_dbg:
	gcc -ggdb -g3 -O0 -o lfsr lfsr.c
run:
	./compile.sh moy_pid.l
	./moy_pid_

#clear output files
cof:
	echo -n > crypt.txt > decrypt.txt
lfsrl: lfsrl
	rm lfsr_.l lfsr_.s
lfsrc: lfsrc
	./lfsr
runl: build_lfsrl
	./lfsrl_
clean:
	rm lfsr_.s lfsr_.o
