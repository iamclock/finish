main(/)
	*test_lfsr(/)
	
**

*** алгоритм подсчёта веса с булевых функций быстрее побитового сдвига?


test_lfsr(/)
	@+L1(100)
	@+L2(100)
	
	4=Q1=Q2
	ffffffffh=L1.1=L1.2=L1.3=L1.0
	28000005h=L2.2 *** 00101000000000000000000000000101 or x^32+x^30+x^3+x^5+1
	OL2.3=L2.1=L2.0
	
	Oi ffffh*32-1=w
	P1
		?(i>w)2 *doLFSR(L1, L2/L1) Di
		*** *printShiftReg(L1/) /'\n'>C
		?=1
	P2 *printShiftReg(L1/) /'\n'>C
**

	/'********************************\n'>C
	/'L1 = '>C *HprintfBN(L1/) /'\n'>C
	/'L2 = '>C *HprintfBN(L2/) /'\n'>C
	/'L3 = '>C *HprintfBN(L3/) /'\n'>C
	/'j = '>C *printf(j/) /'\n'>C
	/'********************************\n'>C

printShiftReg(L1/)
	Q1-1=i Q1/2=w /'0x'>C
	?(Q1>1)1 *** для случая 32ух бит для менее доделать
	L1.0>16=x *Hprintf2(x/)
	/':'>C /'0x'>C
	L1.0&ffffh=x *Hprintf(L1.0/)
	P1
		?(i<w)2 ?(i>Q1)3 *Hprintf2(L1i/) Yi ?=1
	P2
		Ow /':'>C /'0x'>C ?=1
	P3
**


lfsr(/)
	*** lfsr с проверками
**


weight(a/k)
	Ok
	P91
		?(a<1)92 a&1+k=k a>1=a ?=91
	P92
**


*** L1 - shift register L1.0 - low, ..., L1.[Q1-1] - high
*** L2 - tap mask L2.0 - low, ..., L2.[Q2-1] - high
doLFSR(L1, L2/L1)
	Q1+5=k
	@+L3(k)
	@+F4(100)
	?(Q1<1)101
	Q1/2=Q3
	*** /'L1 = '>C *Hprintf2(L1.3/) *Hprintf2(L1.2/) *Hprintf2(L1.1/) *Hprintf2(L1.0/) /'\n'>C
	*** /'L2 = '>C *Hprintf2(L2.3/) *Hprintf2(L2.2/) *Hprintf2(L2.1/) *Hprintf2(L2.0/) /'\n'>C
	?(Q1>1)93
	*** случай для лфср <33 бит
	*** посчитать количество единиц в регистре и уйти в 92, если 0, то выход
	*weight(L1.0/k) ?(k>0)92 ?=101
	
	P93 *** случай для лфср >32 бит
		Q1/2=j-1=w
	Oi
	P91
		?(i>w)94 L1i&L2i=h L1j&L2j=l
		*** /'low: '>C *Hprintf2(l/) /' '>C
		*** /'high: '>C *Hprintf2(h/) /'\n'>C
		h^l=L3i Di Dj ?=91
	P94
		Q3/2=j-1=w Oi
	P95
		?(i>w)92 L3i^L3j=L3i
		*** /'L3 = '>C *HprintfBN2(L3/) /'\n'>C
		Di Dj ?=95
	P92
		*** /'Q3 = '>C *printf(Q3/) /'\n'>C
		*** /'L3 = '>C *HprintfBN(L3/) /'\n'>C
		*** *OxHprintf2(L3.0/) /'\n'>C
		*** *OxHprintf2(L3.1/) /'\n'>C
		*** *printShiftReg(L3/) /'\n'>C
		*** w+1=Q3
		
		L3.0>16=l L3.0&ffffh^l=z
		z>8=l z&ffh^l=x
		x>4=l x&fh^l=c
		c>2=l c&3^l=v
		v>1=l v&1^l=b
		*** /'L3.0 = '>C *printf(L3.0/) /'\n'>C
		*** /'z = '>C *printf(z/) /'\n'>C
		*** /'x = '>C *printf(x/) /'\n'>C
		*** /'c = '>C *printf(c/) /'\n'>C
		*** /'v = '>C *printf(v/) /'\n'>C
		*** /'b = '>C *printf(b/) /'\n'>C
	Q1-1=i-1=j
	P99
		?(j>Q1)100
		L1j>63=v L1i<1|v=L1i Yi Yj ?=99
	P100
		L1.0<1|b=L1.0
	P101
**


		*** /'i = '>C *printf(i/) /'\n'>C
		*** /'j = '>C *printf(j/) /'\n'>C
		*** L2i=f L2j=g ?(Q3=c)94
		*** /'111\n'>C
		*** ffffffffh=f=g
		*** P94
		*** /'f = '>C *OxHprintf2(f/) /'\n'>C
		*** /'g = '>C *OxHprintf2(g/) /'\n'>C




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
doLFSR_old(L1, L2/L1)
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

