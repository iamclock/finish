lfsr:
	./compile.sh lfsr.l
	# ./lfsr_
lfsrc:
	gcc -O0 -o lfsrc lfsr.c
lfsrc_dbg:
	gcc -ggdb -g3 -O0 -o lfsrc lfsr.c
build_moy_pid:
	./compile.sh moy_pid.l
run: build_moy_pid
	./moy_pid_

#clear output files
is_different:
	diff text.txt decrypt.txt
cof:
	echo -n > crypt.txt > decrypt.txt
rm_useless_moy_pid_files:
	rm moy_pid_.s moy_pid_.l
clean_lfsr:
	rm lfsr_.s lfsr_.o


command:
	echo "make cof && ./compile.sh moy_pid.l && ./moy_pid_ > /tmp/deep.log"
command2:
	echo "for i in `seq 11`; do time ./decr; done |& tee -a ./decr_times.txt"