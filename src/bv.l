**************************************************************
******************		Булев вектор		******************
**************************************************************

*** L1.0 - размер
*** bits/32+3=k - minimum logical`s complex capacity

main(/)
	*** *test_constructor1(/)
	*** *test_constructor3(/)
	*** *test_print(/)
	*** *test_set(/)
	*** *test_get(/)
	*** *test_printPlaces(/)
**



**************************************************************
**********************		Тесты		**********************
**************************************************************

test_constructor1(/)
	50000/32+3=k
	@+L1(k)
	*bv_constructor1(L1, 50000, 0/L1)
	*** /'size = '>C *printf(L1.0/) /'\n'>C
**


test_constructor2(/)
	@+L1(1000)
	@+F2(1000)
	*bv_constructor2(L1, F2/L1)
**


test_constructor3(/)
	50000/32+3=k
	@+L1(k)
	*bv_constructor3(L1, 50000, 1/L1)
	1=i Q1-1=w
	P1 ?(i>w)2 *OxHprintf2(L1i/) /' '>C Di ?=1
	P2 /'\n'>C
**


test_print(/)
	50000/32+3=k
	@+L1(k)
	*bv_constructor3(L1, 49983, 1/L1)
	*bv_print(L1/) /'\n'>C
**


test_set(/)
	51/32+3=k
	@+L1(k)
	*bv_constructor3(L1, 51, 0/L1)
	*bv_print(L1/) /'\n'>C
	*bv_set(L1, 5, 1/L1) *bv_print(L1/) /'\n'>C
	*bv_set(L1, 6, 1/L1) *bv_print(L1/) /'\n'>C
	*bv_fill(L1, 1/L1)
	*bv_set(L1, 7, 0/L1) *bv_print(L1/) /'\n'>C
	*bv_set(L1, 8, 0/L1) *bv_print(L1/) /'\n'>C
**


test_get(/)
	51/32+3=k
	@+L1(k)
	*bv_constructor1(L1, 51, 1/L1)
	*bv_print2(L1/) /'\n'>C
	*bv_print(L1/) /'\n'>C
	*bv_get(L1, 48/b) *printf(b/) /'\n'>C
	*bv_get(L1, 47/b) *printf(b/) /'\n'>C
	*bv_get(L1, 46/b) *printf(b/) /'\n'>C
	*bv_get(L1, 45/b) *printf(b/) /'\n'>C
	*bv_get(L1, 44/b) *printf(b/) /'\n'>C
	*bv_get(L1, 43/b) *printf(b/) /'\n'>C
	*bv_get(L1, 42/b) *printf(b/) /'\n'>C
	*bv_get(L1, 41/b) *printf(b/) /'\n'>C
	*bv_get(L1, 40/b) *printf(b/) /'\n'>C
	*bv_get(L1, 39/b) *printf(b/) /'\n'>C
	*bv_get(L1, 38/b) *printf(b/) /'\n'>C
	*bv_get(L1, 37/b) *printf(b/) /'\n'>C
	*bv_get(L1, 36/b) *printf(b/) /'\n'>C
	*bv_get(L1, 35/b) *printf(b/) /'\n'>C
	*bv_get(L1, 34/b) *printf(b/) /'\n'>C
	*bv_get(L1, 33/b) *printf(b/) /'\n'>C
	
**


test_printPlaces(/)
	51/32+3=k
	@+L1(k)
	*bv_constructor1(L1, 51, 1/L1)
	*bv_print(L1/) /'\n'>C
	*bv_printUnitsPlaces(L1/) /'\n'>C
	*bv_printZerosPlaces(L1/) /'\n'>C
**


**************************************************************
************************	Алгоритмы	**********************
**************************************************************


*** конструктор булева вектора
*** L1 - будущий булев вектор
*** s, L1.0 - размер
*** r - заполнить случайно
bv_constructor1(L1, s, r/L1)
	OZ=Q1 s:32+2=t S1=k ?(k<t)2 t=Q1
	?(Z>0)1 Q1-1=Q1
	P1 s=L1.0 r&1=b ?(b=0)3 *bv_randomFill(L1/L1) ?=3
	P2 /'bv_constructor1 ERROR: L1 capacity is less than require size\n'>C
	P3
**


*** конструктор булева вектора и инициализация
*** L1 - будущий булев вектор
*** F2 - строчное значение булева вектора
*** L1.0 - размер
bv_constructor2(L1, F2/L1)
	
**


*** конструктор булева вектора и инициализация его нулями или единицами
*** L1 - будущий булев вектор
*** s, L1.0 - размер
*** b - значение для инициализации
bv_constructor3(L1, s, b/L1)
	*bv_constructor1(L1, s, 0/L1)
	1&b=t
	*bv_fill(L1, t/L1)
**


*** заполнить булев вектор единицами или нулями
*** b - 0 или 1
bv_fill(L1, b/L1)
	b&1=t 0=v
	1=i Q1-1=w
	?(t=0)1 ffffffffh=v
	P1 ?(i>w)2 v=L1i Di ?=1
	P2
**


*** заполнить булев вектор случайно
bv_randomFill(L1/L1)
	*** 5f6abch=X
	*** T=X
	1=i Q1-1=q
	P1 ?(i>q)2 X&ffffh<16=L1i X&ffffh|L1i=L1i Di ?=1
	P2
**


*** установить бит
*** L1 - булев вектор
*** p - место [0;L1.0)
bv_set(L1, p, b/L1)
	L1.0-1=q
	?(p>q)2
	OZ p:32+1=i Z=s b&1=t
	?(t>0)1 1<s=t ffffffffh^t=t t&L1i=L1i ?=3
	P1 1<s|L1i=L1i ?=3
	P2 /'bv_set ERROR: setting place is greater than vector size\n'>C
	P3
**


*** получить бит
*** L1 - булев вектор
*** p - место [0;L1.0)
bv_get(L1, p/b)
	L1.0-1=q
	?(p>q)1
	OZ p:32+1=i Z=s
	1<s&L1i>s=b ?=2
	P1 /'bv_get ERROR: getting place is greater than vector size\n'>C
	P2
**


*** Из строки в булев вектор
*** L1 - булев вектор
*** F2 - строчное значение булева вектора
bv_Str2Bv(L1, F2/L1)
	
**


*** Из булева вектора в строку
*** L1 - булев вектор
*** F2 - строчное значение булева вектора
bv_Bv2Str(L1, F2/L1)
	
**


*** вывод булева вектора
*** L1 - булев вектор
*** p - текущее положение
*** s - величина сдвига [0;31]
bv_print(L1/)
	Op L1.0-1=q *** p идёт от нуля - значит последний бит равен L1.0-1
	P1 ?(p>q)2 *bv_get(L1, p/b) *printf(b/) Dp ?=1
	P2
**


*** вывод мест булева вектора с единицами
*** L1 - булев вектор
bv_printUnitsPlaces(L1/)
	Op L1.0-1=q *** p идёт от нуля - значит последний бит равен L1.0-1
	P1 ?(p>q)3 *bv_get(L1, p/b) ?(b=0)2 *printf(p/) /' '>C
	P2 Dp ?=1
	P3
**


*** вывод мест булева вектора с нулями
*** L1 - булев вектор
bv_printZerosPlaces(L1/)
	Op L1.0-1=q *** p идёт от нуля - значит последний бит равен L1.0-1
	P1 ?(p>q)3 *bv_get(L1, p/b) ?(b>0)2 *printf(p/) /' '>C
	P2 Dp ?=1
	P3
**


bv_weight(L1/w)
	1=i Q1-1=q Ow
	P1 ?(i>q)2 L1i%+w=w Di ?=1
	P2
**


bv_countZeros(L1/c)
**


bv_countUnits(L1/c)
**


bv_shiftr()
**


bv_shiftl()
**


bv_rotr()
**


bv_rotl()
**


**************************************************************
************************	Old		**************************
**************************************************************


*** вывод булева вектора
*** L1 - булев вектор
*** p - текущее положение
*** s - величина сдвига [0;31]
bv_print2(L1/)
	Op=s 1=i Q1-1=q L1.0-1=w
	P1 ?(i>q)4 
	P2 1<s&L1i>s=b *printf(b/) Ds Dp ?(p>w)4 ?(s>31)3 ?=2
	P3 Di Os ?=1
	P4
**


*** вывод мест булева вектора с единицами
*** L1 - булев вектор
bv_printUnitsPlaces_o(L1/)
	Op=s 1=i Q1-1=w L1.0-1=q
	P1 ?(i>w)5 *** p идёт от нуля - значит последний бит равен L1.0-1
	P2 1<s&L1i>s=b ?(b=0)3 *printf(p/) /' '>C
	P3 Ds Dp ?(p>q)5 ?(s>31)4 ?=2
	P4 Di Os ?=1
	P5
**


*** вывод мест булева вектора с нулями
*** L1 - булев вектор
bv_printZerosPlaces_o(L1/)
	Op=s 1=i Q1-1=w L1.0-1=q
	P1 ?(i>w)5  *** p идёт от нуля - значит последний бит равен L1.0-1
	P2 1<s&L1i>s=b ?(b>0)3 *printf(p/) /' '>C
	P3 Ds Dp ?(p>q)5 ?(s>31)4 ?=2
	P4 Di Os ?=1
	P5
**