main(/)
	*test_lfsr(/)
	
**



test_lfsr(/)
	@+L1(100)
	@+L2(100)
	
	4=Q1=Q2
	ffffffffh=L1.1=L1.2=L1.3=L1.0
	28000005h=L2.0 *** 00101000000000000000000000000101 or x^32+x^30+x^3+x^5+1
	OL2.2=L2.3=L2.1
	
	Oi ffffh*32-1=w
	P1
		?(i>w)2 *lfsr(L1, L2/L1) Di *** ?=1
	P2
	*Hprintf(L1.0/) *Hprintf(L1.1/) /':'>C
	*Hprintf(L1.2/) *Hprintf(L1.3/) /'\n'>C
**


*** L1 - shift register L1.0 - low, L1.[Q1-1] - high
*** L2 - tap mask L2.0 - low, L2.[Q2-1] - high
lfsr(L1, L2/L1)
	@+L3(100)
	@+F4(100)
	Q1=Q3
	L1&L2=L3 Q3/2-1=w=j Oi
	P1
		?(i>w)2 L3i^L3j=L3i Di Dj ?=1
	P2
	w+1=Q3
	L3.0<32>32^L3.1>32=z
	z&ffffh^z>16=x
	x&ffh^x>8=c
	c&fh^c>4=v
	v&3^v>2=b
	b&1^b>1=n
	L1<1|L1>63<1=L1
	L1.0|n=L1.0
**


*** здесь в L1.0 и L2.0 степень 2ки для подсчёта длина регистра и маски
test_lfsr_old(/)
	@+L1(100)
	@+L2(100)
	
	5=Q1=Q2
	7=L1.0=L2.0 *** 2^7 -> 128 bit boolean function
	ffffffffh=L1.1=L1.2=L1.3=L1.4
	28000005h=L2.1 *** 00101000000000000000000000000101 or x^32+x^30+x^3+x^5+1
	OL2.2=L2.3=L2.4
	
	*lfsr(L1, L2/L1)
	
	
**


*** с учётом степени в L1.0, L2.0
*** L1 - shift register L1.0 - low, L1.[Q1-1] - high
*** L2 - tap mask L2.0 - low, L2.[Q2-1] - high
lfsr_old(L1, L2/L1)
	@+L3(100)
	@+F4(100)
	Q1=Q3 Oi Q3-1=w
	P1
		?(i>w)2 L1i&L2i=L3i Di ?=1
	P2 Oi
	P3
		?(i>w)2 i+2=j L3i^L3j j=i ?=3
	z
	
	
	
**

