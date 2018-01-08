**************************************************************************
*******************		Даймон потокового шифрования	******************
**************************************************************************


*** TODO:
*** как лучше сделать форк - 2 процесса или главный процесс порождает процессы под каждую операцию
***+ но тогда будет трудно отлавливать ошибки у порождённых процессов
*** fopen не создаёт файл
*** сколько состояний у автомата
*** 

*** TODO diplom:
*** -------------------------------
*** Обзор по:
***  -генераторам ключевого потока (кратко)
***  -усложнениям LFSR (фильтрующий, комбинирующий и т.д. подробнее)
*** -------------------------------
*** в экспериментальных данных показать % сколько состояний посещено
*** +(при количестве тактов в 10 раз больше, чем число состояний)
*** -------------------------------
*** результаты практики в диплом и на основании метода Флойда сделать
*** +выводы об минимальном значении switchVal
*** -------------------------------
*** линейный конгруэнтный метод для переключения состояний
*** требования к автомату (пример: большая линейная сложность)
*** большое количество состояний автомата => большой текст (больше количества состояний)
*** указывать количество обращений к автомату (такты) 1 мб текста ~ 8 388 608 тактов
*** результаты для одного и того же текста на разных автоматах, провести анализ
*** почему скорость зависит от размера автомата
*** упор на генератор, а не на шифрование
*** -------------------------------


*** DONE:
*** -------------------------------
*** 
*** 
*** -------------------------------


*** SOURCES
*** -----------------------
*** 1. https://habrahabr.ru/post/140095/
*** 2. https://media.readthedocs.org/pdf/pylfsr/latest/pylfsr.pdf
*** 3. https://www.xilinx.com/support/documentation/application_notes/xapp052.pdf
*** 4. http://courses.cse.tamu.edu/walker/csce680/lfsr_table.pdf
*** 5. https://users.ece.cmu.edu/~koopman/lfsr/index.html
*** 6. https://www.rocq.inria.fr/secret/Anne.Canteaut/MPRI/chapter3.pdf [lfsr+finite automata]

*** ************************

main(/)
	*** *main_for_time(/)
	*** *main_encr_decr(/)
	*** *test_visited_states(/)
	*test_diff_visited_states(/)
	*** *lfsr_test(/)
	*** *switchValAnalysePrep(/)
	*** *experiment_time_5mb(/) /'\n'>C
	*** *experiment_time_10mb(/) /'\n'>C
	*** *experiment_time_5mb_10times(/)
	*** *experiment_time_10mb_10times(/)
	*** *experiment_5mb(/) /'\n'>C
	*** *experiment_10mb(/) /'\n'>C
	*** *switchValAnalysePrep_5mb(/)
	*** *switchValAnalysePrep_10mb(/)
**


*** descendant - потомок
*** ancestor - предок
main_encr_decr(/)
	@+L1(5)
	@+L2(5)
	@+F3(100)
			*** полиномы и состояния регистра
	*** 1=Q1=Q2 C3h=L2.0 ffh=L1.0
	*** 1=Q1=Q2 822Bh=L2.0 ffffh=L1.0
	1=Q1=Q2 80200003h=L2.0 ffffffffh=L1.0
	*** 1=Q1=Q2 a3000000h=L2.0 ffffffffh=L1.0
	*** 2=Q1=Q2 80000000h=L2.1 00001324h=L2.0 ffffffffh=L1.0=L1.1
			*** счётчик для смены текущего состояния автомата
	448=c
			*** Число состояний автомата
	*** 134217728=s *** 512 mb
	*** 67108864=s *** 256 mb
	*** 33554432=s *** 128 mb
	*** 8388608=s *** для текста 10 мб
	4194304=s *** для текста 5 мб
	*** 838861=s *** для текста 1 мб
	*** 524288=s *** 2 mb
	*** 1048576=s
		
	*** T=X
	*** X&ffffh<16=p
	*** /'p = '>C *Hprintf(p/) /'\n'>C
	*** X&ffffh|p=p=X *** Инициализация X
	*** /'p = '>C *Hprintf(p/) /'\n'>C
	*** T=o
	*** /'T = '>C *Hprintf(o/) /'\n'>C
	*** o=X
	
	
	C68B8B7Eh=X  *** Для отладки. Убрать
	/'Encrypt\n'>C OQ3 @'text.txt'>F3 ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
	C68B8B7Eh=X *** Для отладки. Убрать
	/'Decrypt\n'>C ffffffffh=L1.0 *decrPrep(L1, L2, c, s/)
	*** *tt(/)
	*** *testMaxL(/)
	*** *submain2(/)
	*** *submain3(/)
	*** *submain1(/)
	*** *test1(/)
**


*** 606.2139078300836kb/s ?
main_for_time(/)
	@+L1(5)
	@+L2(5)
	@+F3(100)
			*** полиномы и состояния регистра
	*** 1=Q1=Q2 C3h=L2.0 ffh=L1.0
	*** 1=Q1=Q2 822Bh=L2.0 ffffh=L1.0
	1=Q1=Q2 80200003h=L2.0 ffffffffh=L1.0
	*** 1=Q1=Q2 a3000000h=L2.0 ffffffffh=L1.0
	*** 2=Q1=Q2 80000000h=L2.1 00001324h=L2.0 ffffffffh=L1.0=L1.1
			*** счётчик для смены текущего состояния автомата
	5=c
			*** Число состояний автомата
	*** 134217728=s *** 512 mb
	*** 67108864=s *** 256 mb
	*** 33554432=s *** 128 mb
	*** 8388608=s *** для текста 10 мб
	4194304=s *** для текста 5 мб
	*** 838861=s *** для текста 1 мб
	*** 524288=s *** 2 mb
	*** 1048576=s
	
	
	
	*** C68B8B7Eh=X T=t *time_automatgen(s/) T-t=t *printf(t/)
	/'Encrypt\n'>C OQ3 @'text5.txt'>F3 C68B8B7Eh=X *time_encr(F3, L1, L2, c, s/)
	/'Decrypt\n'>C ffffffffh=L1.0 C68B8B7Eh=X *time_decr(L1, L2, c, s/)
**



***********************************************************************
***************************		Тесты		***************************
***********************************************************************


************************************
**** Эксперименты с автоматами *****
************************************

experiment_time_5mb_10times(/)
	@+L1(5)
	@+L2(5)
	@+F3(100)
	/'experiment_time_5mb_pid\n'>C
			*** полиномы и состояния регистра
	*** 1=Q1=Q2 C3h=L2.0 ffh=L1.0
	*** 1=Q1=Q2 822Bh=L2.0 ffffh=L1.0
	1=Q1=Q2 80200003h=L2.0 ffffffffh=L1.0
	*** 1=Q1=Q2 a3000000h=L2.0 ffffffffh=L1.0
	*** 2=Q1=Q2 80000000h=L2.1 00001324h=L2.0 ffffffffh=L1.0=L1.1
			*** счётчик для смены текущего состояния автомата
	5=c
			*** Число состояний автомата
	4194304=s *** для текста 5 мб
	OQ3 @'text.txt'>F3
	/'Text: ' /F3>C /'\n'>C
	/'Total states: '>C *printf(s/) /'\n'>C
	/'Switch value: '>C *printf(c/) /'\n'>C
	C68B8B7Eh=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P1
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)1
	346b1633h=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P2
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)2
	ed1b14e5h=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P3
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)3
	4d12f02fh=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P4
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)4
	4f0ae47bh=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P5
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)5
	c40bb8cdh=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P6
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)6
	bf7c0d35h=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P7
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)7
	8b124e58h=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P8
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)8
	bee692ach=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P9
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)9
	46d1bbc0h=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P10
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)10
**


experiment_time_10mb_10times(/)
	@+L1(5)
	@+L2(5)
	@+F3(100)
	/'experiment_time_10mb_pid\n'>C
			*** полиномы и состояния регистра
	*** 1=Q1=Q2 C3h=L2.0 ffh=L1.0
	*** 1=Q1=Q2 822Bh=L2.0 ffffh=L1.0
	1=Q1=Q2 80200003h=L2.0 ffffffffh=L1.0
	*** 1=Q1=Q2 a3000000h=L2.0 ffffffffh=L1.0
	*** 2=Q1=Q2 80000000h=L2.1 00001324h=L2.0 ffffffffh=L1.0=L1.1
			*** счётчик для смены текущего состояния автомата
	5=c
			*** Число состояний автомата
	8388608=s *** для текста 10 мб
	
	OQ3 @'text.txt'>F3
	/'Text: ' /F3>C /'\n'>C
	/'Total states: '>C *printf(s/) /'\n'>C
	/'Switch value: '>C *printf(c/) /'\n'>C
	C68B8B7Eh=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P1
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)1
	346b1633h=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P2
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)2
	ed1b14e5h=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P3
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)3
	4d12f02fh=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P4
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)4
	4f0ae47bh=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P5
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)5
	c40bb8cdh=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P6
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)6
	bf7c0d35h=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P7
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)7
	8b124e58h=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P8
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)8
	bee692ach=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P9
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)9
	46d1bbc0h=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C Oi
	P10
		u=X *time_encr(F3, L1, L2, c, s/) Di ?(i<10)10
**


experiment_time_5mb(/)
	@+L1(5)
	@+L2(5)
	@+F3(100)
	/'experiment_time_5mb_pid\n'>C
			*** полиномы и состояния регистра
	*** 1=Q1=Q2 C3h=L2.0 ffh=L1.0
	*** 1=Q1=Q2 822Bh=L2.0 ffffh=L1.0
	1=Q1=Q2 80200003h=L2.0 ffffffffh=L1.0
	*** 1=Q1=Q2 a3000000h=L2.0 ffffffffh=L1.0
	*** 2=Q1=Q2 80000000h=L2.1 00001324h=L2.0 ffffffffh=L1.0=L1.1
			*** счётчик для смены текущего состояния автомата
	5=c
			*** Число состояний автомата
	4194304=s *** для текста 5 мб
	OQ3 @'text.txt'>F3
	/'Text: ' /F3>C /'\n'>C
	/'Total states: '>C *printf(s/) /'\n'>C
	/'Switch value: '>C *printf(c/) /'\n'>C
	C68B8B7Eh=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	346b1633h=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	ed1b14e5h=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	4d12f02fh=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	4f0ae47bh=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	c40bb8cdh=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	bf7c0d35h=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	8b124e58h=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	bee692ach=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	46d1bbc0h=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
**


experiment_time_10mb(/)
	@+L1(5)
	@+L2(5)
	@+F3(100)
	/'experiment_time_10mb_pid\n'>C
			*** полиномы и состояния регистра
	*** 1=Q1=Q2 C3h=L2.0 ffh=L1.0
	*** 1=Q1=Q2 822Bh=L2.0 ffffh=L1.0
	1=Q1=Q2 80200003h=L2.0 ffffffffh=L1.0
	*** 1=Q1=Q2 a3000000h=L2.0 ffffffffh=L1.0
	*** 2=Q1=Q2 80000000h=L2.1 00001324h=L2.0 ffffffffh=L1.0=L1.1
			*** счётчик для смены текущего состояния автомата
	5=c
			*** Число состояний автомата
	8388608=s *** для текста 10 мб
	OQ3 @'text.txt'>F3
	/'Text: ' /F3>C /'\n'>C
	/'Total states: '>C *printf(s/) /'\n'>C
	/'Switch value: '>C *printf(c/) /'\n'>C
	C68B8B7Eh=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	346b1633h=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	ed1b14e5h=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	4d12f02fh=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	4f0ae47bh=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	c40bb8cdh=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	bf7c0d35h=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	8b124e58h=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	bee692ach=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
	46d1bbc0h=X=u /'Seed for automat = '>C *OxHprintf(u/) *time_encr(F3, L1, L2, c, s/)
**


experiment_5mb(/)
	@+L1(5)
	@+L2(5)
	@+F3(100)
	/'experiment_5mb_pid\n'>C
			*** полиномы и состояния регистра
	*** 1=Q1=Q2 C3h=L2.0 ffh=L1.0
	*** 1=Q1=Q2 822Bh=L2.0 ffffh=L1.0
	1=Q1=Q2 80200003h=L2.0 ffffffffh=L1.0
	*** 1=Q1=Q2 a3000000h=L2.0 ffffffffh=L1.0
	*** 2=Q1=Q2 80000000h=L2.1 00001324h=L2.0 ffffffffh=L1.0=L1.1
			*** счётчик для смены текущего состояния автомата
	16=c
			*** Число состояний автомата
	4194304=s *** для текста 5 мб
	OQ3 @'text.txt'>F3
	/'Text: ' /F3>C /'\n'>C
	/'Total states: '>C *printf(s/) /'\n'>C
	/'Switch value: '>C *printf(c/) /'\n'>C
	C68B8B7Eh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
	346b1633h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
	ed1b14e5h=X=u /'Seed for automat = '>C *OxHprintf(u/) *encrPrep(F3, L1, L2, c, s/)
	4d12f02fh=X=u /'Seed for automat = '>C *OxHprintf(u/) *encrPrep(F3, L1, L2, c, s/)
	4f0ae47bh=X=u /'Seed for automat = '>C *OxHprintf(u/) *encrPrep(F3, L1, L2, c, s/)
	c40bb8cdh=X=u /'Seed for automat = '>C *OxHprintf(u/) *encrPrep(F3, L1, L2, c, s/)
	bf7c0d35h=X=u /'Seed for automat = '>C *OxHprintf(u/) *encrPrep(F3, L1, L2, c, s/)
	8b124e58h=X=u /'Seed for automat = '>C *OxHprintf(u/) *encrPrep(F3, L1, L2, c, s/)
	bee692ach=X=u /'Seed for automat = '>C *OxHprintf(u/) *encrPrep(F3, L1, L2, c, s/)
	46d1bbc0h=X=u /'Seed for automat = '>C *OxHprintf(u/) *encrPrep(F3, L1, L2, c, s/)
**


experiment_10mb(/)
	@+L1(5)
	@+L2(5)
	@+F3(100)
	/'experiment_10mb_pid\n'>C
			*** полиномы и состояния регистра
	*** 1=Q1=Q2 C3h=L2.0 ffh=L1.0
	*** 1=Q1=Q2 822Bh=L2.0 ffffh=L1.0
	1=Q1=Q2 80200003h=L2.0 ffffffffh=L1.0
	*** 1=Q1=Q2 a3000000h=L2.0 ffffffffh=L1.0
	*** 2=Q1=Q2 80000000h=L2.1 00001324h=L2.0 ffffffffh=L1.0=L1.1
			*** счётчик для смены текущего состояния автомата
	16=c
			*** Число состояний автомата
	8388608=s *** для текста 10 мб
	OQ3 @'text.txt'>F3
	/'Text: ' /F3>C /'\n'>C
	/'Total states: '>C *printf(s/) /'\n'>C
	/'Switch value: '>C *printf(c/) /'\n'>C
	C68B8B7Eh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
	346b1633h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
	ed1b14e5h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
	4d12f02fh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
	4f0ae47bh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
	c40bb8cdh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
	bf7c0d35h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
	8b124e58h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
	bee692ach=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
	46d1bbc0h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *encrPrep(F3, L1, L2, c, s/)
**


switchValAnalysePrep_5mb(/)
	/'switchValAnalyse_5mb_pid\n'>C
	
	4194303=s *** для текста 5 мб
	*** 524288=s *** 2 mb infinite loop
	5=m
	
	/'Total states: '>C *printf(s/) /'\n'>C
	C68B8B7Eh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	346b1633h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	ed1b14e5h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	4d12f02fh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	4f0ae47bh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	c40bb8cdh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	bf7c0d35h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	8b124e58h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	bee692ach=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	46d1bbc0h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
**


switchValAnalysePrep_10mb(/)
	/'switchValAnalyse_10mb_pid\n'>C
	
	8388607=s *** для текста 10 мб
	*** 524288=s *** 2 mb infinite loop
	5=m
	
	/'Total states: '>C *printf(s/) /'\n'>C
	C68B8B7Eh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	346b1633h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	ed1b14e5h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	4d12f02fh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	4f0ae47bh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	c40bb8cdh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	bf7c0d35h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	8b124e58h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	bee692ach=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
	46d1bbc0h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C *switchValAnalyse(s, m/)
**


switchValAnalyse(s, m/)
	s+5=q
	@+L1(q)
	@+L2(q)
	*** /!\ возможно ли, что Il>5+3 выйдет за границы 32ух бит?
	*BFfindVarCount(s/l) Il>5+3=q *** /'l = '>C *printf(l/) /'\n'>C
	@+L3(q)
	*genAutomat(s, l/L2, L3, x, e)
	*floydsMethodWPrint(L2, 1, 16/) /'\n'>C
	Q2=Q1
	*everyFloydsMethod(L2, 0, Q2/L1)
	*** /'Q1 = '>C *printf(Q1/) /'\n'>C
	*searchMaxMinAvg(L1, o/k, v, l, a)
	/'max = '>C *printf(k/) /'\n'>C
	/'min = '>C *printf(v/) /'\n'>C
	/'less than '>C *printf(m/) /' = '>C *printf(a/) /'\n'>C
	*** /'something = '>C *printf(l/) /'\n'>C
**



*** /' = '>C *HprintfBN(/) /'\n'>C
*** /' = '>C *printf(/) /'\n'>C

************************************
*** Функции для засекания времени **
************************************

time_automatgen(s/)
	s+5=q
	@+L2(q)
	*** /!\ возможно ли, что Il>5+3 выйдет за границы 32ух бит?
	*BFfindVarCount(s/l) Il>5+3=q *** /'l = '>C *printf(l/) /'\n'>C
	@+L3(q)
	*genAutomat(s, l/L2, L3, x, e)
**


time_encr(F1, L4, L5, c, s/)
	*** @+F1(100)
	*** /F1>C /'\n'>C /'Total states: '>C *printf(s/) /'\n'>C /'Switch value: '>C *printf(c/) /'\n'>C
	*** Теперь надо считывать начальное состояние регистра сдвига SEED
	*** OQ1 @'text.txt'>F1
	*fopen(F1, 0/r)
	OQ1 @'crypt.txt'>F1 *fopen(F1, 1/w)
	*** /'r = '>C *printf(r/) /'\n'>C
	*** /'w = '>C *printf(w/) /'\n'>C
	s+5=q
	@+L2(q)
	*BFfindVarCount(s/l) Il>5+3=q
	@+L3(q)
	T=t *genAutomat(s, l/L2, L3, x, e) T-t=t /'genAutomat time = '>C *printf(t/) /'\n'>C
	T=t *cypher(L2, L3, L4, L5, r, w, x, c/e) T-t=t /'cypher time = '>C *printf(t/) /'\n'>C
	*fclose(r/)
	*fclose(w/)
**


time_decr(L4, L5, c, s/)
	@+F1(100)
	
	*** Теперь надо считывать начальное состояние регистра сдвига SEED
	OQ1 @'crypt.txt'>F1 *fopen(F1, 0/r)
	OQ1 @'decrypt.txt'>F1 *fopen(F1, 1/w)
	*** /'r = '>C *printf(r/) /'\n'>C
	*** /'w = '>C *printf(w/) /'\n'>C
	s+5=q
	@+L2(q)
	*BFfindVarCount(s/l) Il>5+3=q
	@+L3(q)
	*genAutomat(s, l/L2, L3, x, e)
	*cypher(L2, L3, L4, L5, r, w, x, c/e)
	*fclose(r/)
	*fclose(w/)
**


test_visited_states(F3, c, s/)
	@+L1(5)
	@+L2(5)
	*** @+F3(100) *** OQ3 @'text10.txt'>F3
	/'Test visited states diplom\n'>C
	
			*** полиномы и состояния регистра
	*** 1=Q1=Q2 C3h=L2.0 ffh=L1.0
	*** 1=Q1=Q2 822Bh=L2.0 ffffh=L1.0
	1=Q1=Q2 80200003h=L2.0 ffffffffh=L1.0
	*** 1=Q1=Q2 a3000000h=L2.0 ffffffffh=L1.0
	*** 2=Q1=Q2 80000000h=L2.1 00001324h=L2.0 ffffffffh=L1.0=L1.1
			*** счётчик для смены текущего состояния автомата
	*** 12=c
			*** Число состояний автомата
	*** 8388608=s OQ3 @'text10.txt'>F3 *** для текста 10 мб
	*** 4194304=s OQ3 @'text5.txt'>F3 *** для текста 5 мб
	/'Text: '>C /F3>C /'\n'>C
	/'Total states: '>C *printf(s/) /'\n'>C
	/'Switch value: '>C *printf(c/) /'\n'>C
	*** убрать первое V (стрелочка)
	8b124e58h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
	C68B8B7Eh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
	346b1633h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
	ed1b14e5h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
	4d12f02fh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
	4f0ae47bh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
	c40bb8cdh=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
	bf7c0d35h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
	8b124e58h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
	bee692ach=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
	46d1bbc0h=X=u /'Seed for automat = '>C *OxHprintf(u/) /'\n'>C ffffffffh=L1.0 *encrPrep(F3, L1, L2, c, s/)
**


test_diff_visited_states(/)
	*** *test_visited_states_10mb(/)
	*test_visited_states_5mb(/)
**


test_visited_states_10mb(/)
	@+F3(100)
	OQ3 @'text10.txt'>F3 *** для текста 10 мб
	*** 8388607=s 12=c *test_visited_states(F3, c, s/)
	*** 8388608=s 12=c *test_visited_states(F3, c, s/)
	8388607=s 10=c *test_visited_states(F3, c, s/)
	8388607=s 100=c *test_visited_states(F3, c, s/)
	8388607=s 500=c *test_visited_states(F3, c, s/)
	8388608=s 10=c *test_visited_states(F3, c, s/)
	8388608=s 100=c *test_visited_states(F3, c, s/)
	8388608=s 500=c *test_visited_states(F3, c, s/)
**

test_visited_states_5mb(/)
	@+F3(100)
	OQ3 @'text5.txt'>F3 *** для текста 5 мб
	*** 4194303=s 12=c *test_visited_states(F3, c, s/)
	4194304=s 12=c *test_visited_states(F3, c, s/)
	4194303=s 10=c *test_visited_states(F3, c, s/)
	4194303=s 100=c *test_visited_states(F3, c, s/)
	4194303=s 500=c *test_visited_states(F3, c, s/)
	4194304=s 10=c *test_visited_states(F3, c, s/)
	4194304=s 100=c *test_visited_states(F3, c, s/)
	4194304=s 500=c *test_visited_states(F3, c, s/)
**



lfsr_test(/)
	@+L1(100)
	@+L2(100)
	
	
	2=Q1=Q2
	80000000h=L2.1 00001324h=L2.0
	ffffffffh=L1.0=L1.1
	Oi 70=w
	*printShiftReg(L1/) /'\n'>C
	P1
		?(i>w)2 *doLFSR(L1, L2/L1, b) Di
		*** *printf(b/) /' '>C
		*printShiftReg(L1/) /'\n'>C
		?=1
	P2 /'\n'>C *printShiftReg(L1/) /'\n'>C
**


daemon_submain(/)
	@+F1(100)
	@'text.txt'>F1
	*** открытие файла с текстом на чтение
	*** *fopen(F1, 0/t)
	*fork(/p)
	?(p#0)2 *** потомок или предок
	P1
			*descendant(/) ?=3
	P2
			*setPidFile(p/)
			*ancestor(/)
	P3
	*fclose(t/)
**


tt(/)
	*** 939524096=m		*** 3,5 Gb
	995999999=m	*** perfectly work (3,68 Gb) *** segfault for 1024 and 2024?
	*** 1006632960=m	*** segfault 3,75 Gb
	*** 2095000=m	*** C's segfault
	@+L1(m)
	@+L2(m)
	m=Q1=Q2
	/'Q1 = '>C *printf(Q1/) /'\n'>C
	/'Q2 = '>C *printf(Q2/) /'\n'>C
	OL1.1024 OL1.2025
	OL1.1025 OL1.2024
	Oi
	P1
		OL1i
		*** OL2i
		Di ?(i<Q1)1
	
**


keygenerate_test_big(/)
	@+F1(100)
	*** *keyGenerate(0, 128, 335544320/F1, e)
	*** *keyGenerate(0, 128, 402653184/F1, e)
	*keyGenerate(0, 128, 268435456/F1, e)
	*** /'e = '>C *printf(e/) /'\n'>C
	*printFComplex(F1/) /'\n'>C
**

keygenerate_test_little(/)
	@+F1(100)
	*** *keyGenerate_test(0, 128/F1, e)
	*keyGenerate_test(0, 16/F1, e)
	*** /'e = '>C *printf(e/) /'\n'>C
	*** *printFComplex(F1/) /'\n'>C
**


*** найти min, avg, max среди всех состояний
*** для большого числа состояний для нескольких случайных

*** for testing
keyGenerate_test_huge(n, m/F4, e)
	128=m	*** 2^7
	*** 32=m	*** 2^5
	*** 16=m	*** 2^4
	*** 134217728=m		*** for 512 Mb
	*** 268435456=m		*** for 1 Gb
	*** 335544320=m		*** 1,256
	*** 402653184=m		*** 1,5 Gb
	*** 536870912=m		*** 2 Gb
	*** 805306368=m		*** 3Gb
	*** 939524096=m		*** 3,5 Gb
	*** 959999999=m		*** 3,69 Gb
	*** 962999999=m		*** 3,71 Gb
	*** 1006632960=m	*** segfault 3,75 Gb
	*** 1073741824=m	*** segfault 4Gb
	@+L4(1000)
	m=Q4
	1=e
	*** /'m = '>C *printf(m/) /'\n'>C
	*** 2=n
	?(n=0)98
	*blankShot(n/)
	P98
		m+5=q
		@+L1(q) m=Q1
		*randLCompMod(L1, m/)
		*BFfindVarCount(m/l) Il>5+3=q
		/'q = '>C *printf(q/) /'\n'>C
		@+L2(q) *BFrand(L2, l/L2) *** *BFoutput_s(L2/) /'\n'>C
		*** /'L1 = '>C *printLComplex(L1/) /'\n'>C
		*** /'L2 = '>C *HprintfBN(L2/) /'\n'>C
		*floydsMethodWPrint(L1, 0, Q1/) /'\n'>C
		
		*printDiagram(L4, L1/) /'\n'>C
		*searchMaxMinAvg(L4/k, v, l)
		/'max = '>C *printf(k/) /'\n'>C
		/'min = '>C *printf(v/) /'\n'>C
		/'avg = '>C *printf(l/) /'\n'>C
		
		OZ b:8+1=t Z=q *** S3-1=w
		*** b;8=q	*** Исправить, сделать покрасивее, в одно действие
		?(q=0)99 Yt			*** Исправить, сделать покрасивее
	P99					*** Исправить, сделать покрасивее
		?(t>S3)100 Oe X;m=x
		*** *genKeyStream(x, L1, L2, t/F3, e)
	P100
**


searchAvg(L1/)
**

test1(/)
	@+F1(100)
	OQ1 @'text.txt'>F1 *fopen(F1, 0/r)
	OQ1 @'crypt.txt'>F1 *fopen(F1, 0/w)
	/'r = '>C *printf(r/) /'\n'>C
	/'w = '>C *printf(w/) /'\n'>C
	@+L2(100)
	OQ1 @'0x3777BF4446C2C4159FF940DAF0135123FE4641C05A0171C1A31E6776E848A96F21A72B7C7DC75FAD6F253B52096FBFFBB'>F1 *inputBN_2(L2, F1/L2)
	/'L2 = '>C *HprintfBN(L2/) /'\n'>C
	*encrypt(r, w, L2/e)
	*fclose(r/)
	*fclose(w/)
**

testMaxL2(/)
	268435455=l
	*** 1073741823=k *** segfault, вывод есть
	*** 727380000=k *** и выше иногда появляется segfault при создании 2ух и более больших комплексов
	*** 727379999=k *** segfault, вроде отсутствует при создании 2ух комплексов
	*** 402653184=k *** 1,5 Gb
	*** 268435456=k *** 1 Gb
	268435456=k
	@+L1(l)
	@+L2(1073741823)
	*** @+L3(k)
	*** @+L4(k)
	*** @+L5(k)
	
	*** разные варианты, чтобы убрать ошибку с 1025. Не сработали
	k/4=Q1 k/4=Q2
	*** 268435455=Q1 1073741823=Q2
	*printf(Q1/) /' '>C *printf(Q2/) /'\n'>C
	S1=a S2=b
	*printf(a/) /' '>C *printf(b/) /'\n'>C
	*** OL1.1024		*** work
	*** OL1.1025		*** work
	*** OL2.1024		*** good
	OL2.1025
	
	*** *printf(Q1/) /'\n'>C
	*** *printf(Q2/) /'\n'>C
	Oi=j
	P1
		*** i=L2i
		*** *printf(i/) /' '>C
		*** Di ?(i<Q2)1 Dj Oi ?(j<10)1
	*** @-L1
	*** @-L2
**



testMaxL(/)
	268435455=l
	*** 1073741823=k *** segfault, вывод есть
	*** 727380000=k *** и выше иногда появляется segfault при создании 2ух и более больших комплексов
	*** 727379999=k *** segfault, вроде отсутствует при создании 2ух комплексов
	*** 402653184=k *** 1,5 Gb
	*** 268435456=k *** 1 Gb
	268435456=k
	@+L1(l)
	@+L2(k)
	*** @+L3(k)
	*** @+L4(k)
	*** @+L5(k)
	
	*** разные варианты, чтобы убрать ошибку с 1025. Не сработали
	S1/4=Q1 S2/4=Q2
	*** 268435455=Q1 1073741823=Q2
	*printf(Q1/) /' '>C *printf(Q2/) /'\n'>C
	S1=a S2=b
	*printf(a/) /' '>C *printf(b/) /'\n'>C
	*** OL1.1024		*** work
	*** OL1.1025		*** work
	*** OL2.1024		*** good
	OL2.1025
	
	*** *printf(Q1/) /'\n'>C
	*** *printf(Q2/) /'\n'>C
	Oi=j
	P1
		*** i=L2i
		*** *printf(i/) /' '>C
		*** Di ?(i<Q2)1 Dj Oi ?(j<10)1
	*** @-L1
	*** @-L2
**

**************************************************************************
**************************		Алгоритмы		**************************
**************************************************************************

**************************************************************
******************		Булев вектор		******************
**************************************************************

*** L1.0 - размер
*** bits/32+3=k - minimum logical`s complex capacity

*** конструктор булева вектора
*** L1 - будущий булев вектор
*** s, L1.0 - размер
*** r - заполнить случайно
bv_constructor1(L1, s, r/L1)
	OZ=Q1 s:32+2=t S1=k ?(k<t)2 t=Q1
	?(Z>0)1 Q1-1=Q1
	P1 s=L1.0 ?(r=0)3 *bv_randomFill(L1/L1) ?=3
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
	T=X
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
bv_printOnesPlaces(L1/)
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

***********************************************************************


*** подготовка к шифрованию и шифрование
*** [Это может быть в главной функции]
*** L4 - регистр сдвига
*** L5 - полином для LFSR
*** L6 - булев вектор для проверки посещённых состояний автомата
*** c - счётчик для смены текущего состояния автомата [switch]
*** s - количество состояний
encrPrep(F1, L4, L5, c, s/)
	*** @+F1(100)
	*** /F1>C /'\n'>C /'Total states: '>C *printf(s/) /'\n'>C /'Switch value: '>C *printf(c/) /'\n'>C
	*** Теперь надо считывать начальное состояние регистра сдвига SEED
	*** OQ1 @'text.txt'>F1
	*fopen(F1, 0/r)
	*** OQ1 @'crypt.txt'>F1 *fopen(F1, 1/w)
	*** /'r = '>C *printf(r/) /'\n'>C
	*** /'w = '>C *printf(w/) /'\n'>C
	
	*** X>16;2000=k *** ключ [key]
	*** возможные состояния [states]
	*** 524288=s		*** for 2 mb
	*** 33554432=s		*** for 128 mb
	*** 67108864=s		*** for 256 mb
	*** 134217728=s		*** for 512 Mb
	*** 268435456=s		*** for 1 Gb
	*** 335544320=s		*** for 1,256
	*** 402653184=s		*** for 1,5 Gb
	*** 536870912=s		*** for 2 Gb
	*** 805306368=s		*** for 3Gb
	*** 939524096=s		*** for 3,5 Gb
	*** 1006632960=s	*** segfault at 3,75 Gb
	*** 1073741824=s	*** segfault at 4Gb
	*** *******************
	
	*** 5A1F0535h=X
	*** 5000=s
	
	s+5=q
	@+L2(q)
	*** /!\ возможно ли, что Il>5+3 выйдет за границы 32ух бит?
	*BFfindVarCount(s/l) Il>5+3=q *** /'l = '>C *printf(l/) /'\n'>C
	@+L3(q)
	s/32+3=k
	@+L6(k)
	*bv_constructor3(L6, s, 0/L6)
	*** /'automat`s size = '>C *printf(s/) /'\n'>C
	*** /'switch = '>C *printf(c/) /'\n'>C
	/'Visited states before cyphering = '>C *bv_weight(L6/t) *printf(t/) /'\n'>C
	*** /'k = '>C *printf(k/) /'\n'>C
	*genAutomat(s, l/L2, L3, x, e)
	*** Q2+2=t @+L7(t) Q2=Q7 *everyFloydsMethod(L2, 0, Q2/L7) /'\n'>C
	*** *floydsMethodWPrint(L2, 1, 16/) /'\n'>C
	*** *searchMaxMinAvg(L7, 10/o, p, r, a)
	*cypher_wbv(L2, L3, L4, L5, L6, r, w, x, c/L6, e)
	*** *bv_printOnesPlaces(L6/) /'\n'>C
	*** *bv_print(L6/) /'\n'>C
	/'Visited states after cyphering = '>C *bv_weight(L6/t) *printf(t/) /'\n'>C
	*fclose(r/)
	*** *fclose(w/)
**


*** подготовка к расшифрованию и расшифрование
*** [Это может быть в главной функции]
*** L4 - регистр сдвига, seed
*** L5 - полином для LFSR
*** L6 - булев вектор для проверки посещённых состояний автомата
*** c - счётчик для смены текущего состояния автомата [switch]
*** s - количество состояний
decrPrep(L4, L5, c, s/)
	@+F1(100)
	
	OQ1 @'crypt.txt'>F1 *fopen(F1, 0/r)
	OQ1 @'decrypt.txt'>F1 *fopen(F1, 1/w)
	*** /'r = '>C *printf(r/) /'\n'>C
	*** /'w = '>C *printf(w/) /'\n'>C
	
	*** возможные состояния [states]
	*** 33554432=s		*** for 128 mb
	*** 67108864=s		*** for 256 mb
	*** 134217728=s		*** for 512 Mb
	*** 268435456=s		*** for 1 Gb
	*** 335544320=s		*** for 1,256
	*** 402653184=s		*** for 1,5 Gb
	*** 536870912=s		*** for 2 Gb
	*** 805306368=s		*** for 3Gb
	*** 939524096=s		*** for 3,5 Gb
	*** 1006632960=s	*** segfault at 3,75 Gb
	*** 1073741824=s	*** segfault at 4Gb
	*** *******************
	
	*** 5A1F0535h=X
	*** 5000=s
	s+5=q
	@+L2(q)
	*** /!\ возможно ли, что Il>5+3 выйдет за границы 32ух бит?
	*BFfindVarCount(s/l) Il>5+3=q
	@+L3(q)
	s/32+3=k
	@+L6(k)
	*bv_constructor3(L6, s, 0/L6)
	*** /'automat`s size = '>C *printf(s/) /'\n'>C
	*** /'switch = '>C *printf(c/) /'\n'>C
	/'weight before = '>C *bv_weight(L6/t) *printf(t/) /'\n'>C
	
	*** /'k = '>C *printf(k/) /'\n'>C
	*** /'s = '>C *printf(s/) /'\n'>C
	*** /'l = '>C *printf(l/) /'\n'>C
	*genAutomat(s, l/L2, L3, x, e)
	*cypher_wbv(L2, L3, L4, L5, L6, r, w, x, c/L6, e)
	*** *bv_printOnesPlaces(L6/)
	*** *bv_print(L6/)
	/'weight = '>C *bv_weight(L6/t) *printf(t/) /'\n'>C
	*fclose(r/)
	*fclose(w/)
**


*** Шифрование/Расшифрование
*** L1 - таблица переходов автомата
*** L2 - функция выходов автомата
*** L5 - регистр сдвига LFSR
*** L6 - полином LFSR
*** r - дескриптор файла с текстом/криптограммой
*** w - дескриптор файла с криптограммой/расшифрованным текстом
*** F3 - ключевой поток
*** s - счётчик для смены текущего состояния автомата [switch]
*** e - код возврата(0 - хорошо)
cypher(L1, L2, L5, L6, r, w, x, s/e)
	1010=n Oe=l
	@+F3(n)
	@+F4(n)
	1000=n
	*** /'s = '>C *printf(s/) /'\n'>C
	2=a 3=c 5=m *** 3=s
	P1
		OQ4 *freadf(r, F4, 0, n/k)
		?(k<1)2 k=Q4=Q3
		*genKeyStream(x, L1, L2, L5, L6, k, s, l/F3, L5, x, s, l, e)
		*** /'		x = '>C *printf(x/) /'\n'>C
		*** *lcg(a, s, c, m/s) *** /'s = '>C *printf(s/) /'\n'>C
		*** *xorF(F3, F4/F4) *** F3^F4=F4
		*** *fwritef(w, F4, 0, Q4/k)
		*** /'k = '>C *printf(k/) /'\n'>C
		?=1
	P2
**


*** Шифрование/Расшифрование с булевым вектором
*** L1 - таблица переходов автомата
*** L2 - функция выходов автомата
*** L5 - регистр сдвига LFSR
*** L6 - полином LFSR
*** L7 - булев вектор для проверки посещённых состояний автомата
*** r - дескриптор файла с текстом/криптограммой
*** w - дескриптор файла с криптограммой/расшифрованным текстом
*** F3 - ключевой поток
*** s - счётчик для смены текущего состояния автомата [switch]
*** e - код возврата(0 - хорошо)
cypher_wbv(L1, L2, L5, L6, L7, r, w, x, s/L7, e)
	1010=n Oe=l
	@+F3(n)
	@+F4(n)
	1000=n
	*** /'s = '>C *printf(s/) /'\n'>C
	*** 2=a 3=c 5=m *** период 3
	*** 3=a 7=c 16=m *** период 7
	*** 5=a 7=c 53=m *** период 52
	11=a 7=c 13=m
	P1
		OQ4 *freadf(r, F4, 0, n/k)
		*** /'k = '>C *printf(k/) /' '>C
		?(k<1)2 k=Q4=Q3
		*genKeyStream_wbv(x, L1, L2, L5, L6, L7, k, s, l/F3, L5, L7, x, s, l, e)
		*** /'		x = '>C *printf(x/) /'\n'>C
		*lcg(a, s, c, m/s) *** /'s = '>C *printf(s/) /'\n'>C
		*** *xorF(F3, F4/F4) *** F3^F4=F4
		*** *fwritef(w, F4, 0, Q4/k)
		*** /'k = '>C *printf(k/) /'\n'>C
		?=1
	P2
**


*** Линейный конгруэнтный метод
lcg(a, x, c, m/x)
	a*x+c;m=x
**


*** ведомый автомат
*** L1 - таблица переходов автомата
*** L2 - функция выходов автомата
*** b	- выходной бит
*** x	- выходное состояние
automatB(x, L1, L2/b, x)
	*Boutput(x, L2/b)
	*BnextState(x, L1/x)
**


BnextState(x, L1/x)
	L1x=x
**


*** b - 1 бит
Boutput(x, L1/b)
	*** булевая функция L1
	*BFget(L1, x/b)
**


blankShot(n/)
	Oi
	P1
		X Di ?(i<n)1
**


*** Метод Флойда проверки таблицы переходов автомата
*** L1	- таблица состояний
*** r	- результат
*** c	- длина периода
floydsMethod(L1/r, c)
	Ox=y=c+1=r
	
	P1 
		*BnextState(x, L1/x)
		*BnextState(y, L1/y)
		*BnextState(y, L1/y)
		Dc ?(x#y)1
	P2
		*** /'x = '>C *printf(x/) /'\n'>C
		?(c#Q1)3 Or
	P3
**

*** сумма по модулю 2 для F
xorF(F1, F2/F3)
	?(Q1#Q2)2
	Oi Q1-1=w
	P1 ?(i>w)3
		F1i^F2i=F3i Di ?=1
	P2
		/'exclusiveOrF: ERROR: Комплексы не равны\n'>C
	P3
**


*** Генератор Ключевой последовательности
*** x - начальное состояние автомата
*** L1 - таблица переходов автомата
*** L2 - функция выходов автомата
*** F3 - ключевой поток
*** L4 - регистр сдвига
*** L5 - полином для регистра сдвига
*** n - мощность комплекса F3
*** s - счётчик для смены текущего состояния автомата [switch]
*** l - номер текущего обращения
*** e - признак ошибки
genKeyStream(x, L1, L2, L4, L5, n, s, l/F3, L4, x, s, l, e)
	n=Q3-1=w Oi s+1=q
	*** /'s = '>C *printf(s/) /'\n'>C
	P1 ?(i>w)4 Oj=F3i
	P2 ?(j>7)3
		Dl *** /'l = '>C *printf(l/) /'\n'>C
		?(l<q)93 *doLFSR(L4, L5/L4, b) Ol L4.0;Q1=x *** no eto ne tochno L4.0&2^y=x
		*** /'LFSR done\n'>C
		*** /'L4.0 = '>C *Hprintf(L4.0/) /'\n'>C
	P93
		*** /'x = '>C *printf(x/) /'\n'>C
		*automatB(x, L1, L2/b, x)
		b<j|F3i=F3i Dj
		?=2
	P3
		Di ?=1
	P4
**



*** Генератор Ключевой последовательности с булевым вектором
*** x - начальное состояние автомата
*** L1 - таблица переходов автомата
*** L2 - функция выходов автомата
*** F3 - ключевой поток
*** L4 - регистр сдвига
*** L5 - полином для регистра сдвига
*** L6 - булев вектор для проверки посещённых состояний автомата
*** n - мощность комплекса F3
*** s - счётчик для смены текущего состояния автомата [switch]
*** l - номер текущего обращения
*** e - признак ошибки
genKeyStream_wbv(x, L1, L2, L4, L5, L6, n, s, l/F3, L4, L6, x, s, l, e)
	n=Q3-1=w Oi s+1=q
	*** 2=a 3=c 7=m *** 3=s
	2=a 3=c 7=m *** 3=s
	*** /'s = '>C *printf(s/) /'\n'>C
	P1 ?(i>w)4 Oj=F3i
	P2 ?(j>7)3
		Dl
		?(l<q)93 *doLFSR(L4, L5/L4, b) Ol L4.0;Q1=x *** no eto ne tochno L4.0&2^y=x
		*** /'l = '>C *printf(l/) /'\n'>C
		*** /'s = '>C *printf(s/) /'\n'>C
		*** *lcg(a, s, c, m/s) s+1=q /'s = '>C *printf(s/) /'\n'>C
		*** /'LFSR done\n'>C
		*** /'L4.0 = '>C *Hprintf(L4.0/) /'\n'>C
	P93
		*** /'x = '>C *printf(x/) /'\n'>C
		*bv_set(L6, x, 1/L6)
		*automatB(x, L1, L2/b, x)
		b<j|F3i=F3i Dj
		?=2
	P3
		Di ?=1
	P4
**



*** генерация автомата
*** m - число состояний, мощность L1
*** l - мощность L2
*** x - начальное состояние автомата
*** L1 - таблица переходов автомата
*** L2 - функция выходов автомата
*** e - код возврата(0 - хорошо)
genAutomat(m, l/L1, L2, x, e)
	Oe
	P1
		m=Q1 l=Q2
		*randLCompMod(L1, m/)
		*BFrand(L2, l/L2) *** *BFoutput_s(L2/) /'\n'>C
		X;m=x
**


*** Метод Флойда проверки таблицы переходов автомата
*** L1	- таблица состояний
*** c	- длина периода
*** b	- признак случайного перебора {0, 1}
*** s	- количество циклов
everyFloydsMethod(L1, b, s/L2)
	Oi
	?(i>=s)4
	P1
		i=x=y=j Oc ?(b<1)2 X;Q1=x=y=j
	P2
		*BnextState(x, L1/x)
		*BnextState(y, L1/y)
		*BnextState(y, L1/y)
		Dc ?(x#y)2
	P3
		c=L2j Di ?(i<s)1
	P4
**


printDiagram(L1, L2/)
	Oi
	/'*************************************************\n'>C
	/'| состояние	| следующее	| период	|\n'>C
	/'|-----------------------------------------------|\n'>C
	P1
		/'|	'>C *printf(i/) /'	|	'>C *printf(L2i/) /'	|	'>C *printf(L1i/) /'	|\n'>C
		Di ?(i<Q1)1
	/'*************************************************'>C
**


*** Метод Флойда проверки таблицы переходов автомата с выводом таблицы
*** L1	- таблица состояний
*** c	- длина периода
*** b	- признак случайного перебора {0, 1}
*** s	- количество циклов
floydsMethodWPrint(L1, b, s/)
	Oi
	?(i>=s)4
	/'*************************************************\n'>C
	/'| состояние	| следующее	| период	|\n'>C
	/'|-----------------------------------------------|\n'>C
	P1
		i=x=y=j Oc ?(b<1)2 X;Q1=x=y=j
		*** X&3fffffh;Q1=x=y=j
	P2
		*BnextState(x, L1/x)
		*BnextState(y, L1/y)
		*BnextState(y, L1/y)
		Dc ?(x#y)2
	P3
		/'|	'>C *printf(j/) /'	|	'>C *printf(L1j/)
		/'	|	'>C *printf(c/) /'	|\n'>C
		Di ?(i<s)1
	P4
		/'*************************************************'>C
**


searchMaxMinAvg(L1, m/k, v, l, a)
	?(Q1<1)5
	Oi=a=f Q1=w Yw m-1=n *** a - количество элементов меньше m
	L1.0+1=k-2=v+1=l *** max, min, avg
	P1
		?(i>w)6 ?(L1i<k)2 L1i+1=k
	P2
		?(L1i>v)3 L1i-1=v ?(L1i>0)3 L1i=v 1=f *** f=1, чтобы не увеличивать v в конце, значит оно уже равно 0
	P3
		?(L1i>n)4 Da
	P4
		*** l+L1i=l
		Di ?=1 *** l/Q1=l
	P5
		/'searchMaxMinAvg: ERROR: Q1 equals zero\n'>C
	P6 Yk ?(f=0)7 Dv
	P7
**


printShiftReg(L1/)
	Q1-1=i Q1/2=w /'0x'>C
	?(Q1>1)1 *** для случая 32ух бит для менее доделать
	L1.0>16=x *Hprintf2(x/)
	/':'>C /'0x'>C
	L1.0&ffffh=x *Hprintf(x/) ?=3
	P1
		?(i<w)2 ?(i>Q1)3 *Hprintf2(L1i/) Yi ?=1
	P2
		Ow /':'>C /'0x'>C ?=1
	P3
**


*** LFSR Галуа
*** L1 - регистр сдвига
*** L2 - полином
doLFSR(L1, L2/L1, b)
	?(Q1=0)2
	L1.0&1=b L1>1=L1 ?(b=0)3
	L1^L2=L1 ?=3
	P2 /'doLFSR: ERROR: Q1 equals 0\n'>C
	P3
**


*** LFSR Фибоначи
*** L1 - регистр сдвига
*** L2 - полином
doSlowLFSR(L1, L2/L1, b)
	Q1+5=k
	@+L3(k)
	@+F4(100)
	?(Q1<1)100
	Q1/2=Q3
	?(Q1>1)93
	*** случай для лфср <33 бит
	*** посчитать количество единиц в регистре и уйти в 92, если 0, то выход
	1=Q3 L1.0&L2.0=L3.0
	L1.0%=k ?(k>0)92 ?=100
	P93 *** случай для лфср >32 бит
		Q1/2-1=i Q1-1=j
	P91
		?(i>w)94 L1i&L2i=h L1j&L2j=l
		h^l=L3i Yi Yj ?=91
	P94
		Q3/2-1=i Q3-1=j
	P95
		?(i>Q3)92
		L3i^L3j=L3i
		Yi Yj ?=95
	P92
		L3.0>16=l L3.0&ffffh^l=z
		z>8=l z&ffh^l=x
		x>4=l x&fh^l=c
		c>2=l c&3^l=v
		v>1=l v&1^l=b
	L1<1=L1 L1.0<1|b=L1.0
	P100
**



*** *****************************
*** *********	Old 	*********
*** *****************************


FtoL(F1/L2)
	Oi=j=s=L2j
	*** возможно проверка нужна, но при работе с заведомо корректными 
	***+ данными можно отбросить
	*** ?(Q1<1)5 ?(S2<1)3
	*** *********************
	Q1-1=w S2-1=v
	P1
		F1i<s|L2j=L2j Di ?(i>w)4 s+8=s ?(s>24)2 ?=1
	P2
		Os Dj ?(j>v)3 OL2j ?=1
	P3
		OQ2 /'[FtoL]: ERROR: Не хватило размерности L2\n'>C ?=5
	P4
		j+1=Q2
	P5
**


*** Процесс потомок
*** 
descendant(/)
	Oi=t t-1/2=t
	/'descendant\n'>C
	P1 Di ?(i<t)1
**


*** Процесс предок
*** p - pid потомка
*** 
ancestor(/)
	Oi=t t-1/2=t
	/'ancestor\n'>C
	P1 Di ?(i<t)1
**




*** ведущий автомат
automatA(L1, L2, F3/L4, x)
	@+L1(100)
	@+L2(100)
	@+F3(100)
	/'AutomatA\n'>C
	
	*Aoutput(x, L2/F3)
	*AnextState(x, L1/ x)
**


AnextState(x, L1/x)
	L2x=x
**


*** b - 1 бит
Aoutput(x, L1/b)
	L1x&1=b
**


*** n - количество пустых итераций по X (blank shot)
*** m - количество состояний
*** e - признак ошибки
keyGenerate_dontWork_seeOld(n, m/F3, e)
	1=e
	P1
		m+5=q
		@+L1(q)
		*BFfindVarCount(m/l) Il>5+3=q *** /'l = '>C *printf(l/) /'\n'>C
		@+L2(q)
		*** /'L1 = '>C *printLComplex(L1/) /'\n'>C
		*** /'L2 = '>C *HprintfBN(L2/) /'\n'>C
		OZ l:8+1=t Z=q *** S3-1=w
		*** l;8=q	*** Исправить, сделать покрасивее, в одно действие
		?(q>0)2 Yt			*** Исправить, сделать покрасивее
	P2					*** Исправить, сделать покрасивее
		?(t>S3)3 Oe X;m=x
		*genKeyStream(x, L1, L2, t/F3, e)
	P3
**





*** l - количество бит
*** n - количество пустых итераций по X (blank shot)
*** m - количество состояний
*** e - признак ошибки
keyGenerate_old(n, l, m/F3, e)
	1=e
	?(n=0)1 *blankShot(n/)
	P1
		m+5=q
		@+L1(q) m=Q1
		*randLCompMod(L1, m/)
		*BFfindVarCount(m/l) Il>5+3=q *** /'l = '>C *printf(l/) /'\n'>C
		@+L2(q) *BFrand(L2, l/L2) *** *BFoutput_s(L2/) /'\n'>C
		*** /'L1 = '>C *printLComplex(L1/) /'\n'>C
		*** /'L2 = '>C *HprintfBN(L2/) /'\n'>C
		OZ l:8+1=t Z=q *** S3-1=w
		*** l;8=q	*** Исправить, сделать покрасивее, в одно действие
		?(q>0)2 Yt			*** Исправить, сделать покрасивее
	P2					*** Исправить, сделать покрасивее
		?(t>S3)3 Oe X;m=x
		*genKeyStream(x, L1, L2, t/F3, e)
	P3
**


*** Расшифрование
*** r - дескриптор файла с криптограммой
*** w - дескриптор файла с исходным, расшифрованным текстом
*** L1 - ключ
*** e - код возврата(0 - хорошо)
decrypt_old(r, w, L1/e)
	Oe Q1=n*4=q
	@+L2(n) OQ2
	@+F3(q) OQ3
	P1
		OQ3 *freadf(r, F3, 0, q/k)
		*** /'k = '>C *printf(k/) /' '>C
		?(k<1)2 k=Q3
		*** *** /F3>C /'\n'>C
		*strToBlock(F3, L2/L2, p)
		Q2=Q1 *** от ошибки internal error на последнем шаге
		L2^L1=L2
		*** *HprintfBN(L2/) /'\n'>C
		*blockToStr_forDecrypt(L2, F3/F3, p)
		*** *printFComplex(F3/) /'\n'>C
		*** /F3>C
		*fwritef(w, F3, 0, Q3/k) ?=1
	P2
	
**


*** Шифрование
*** r - дескриптор файла с текстом
*** w - дескриптор файла с криптограммой
*** L1 - ключ
*** e - код возврата(0 - хорошо)
encrypt_old(r, w, L1/e)
	Oe Q1=n*4=q
	@+L2(n) OQ2
	@+F3(q)
	P1
		OQ3 *freadf(r, F3, 0, q/k)
		*** /'k = '>C *printf(k/) /' '>C
		?(k<1)2 k=Q3
		*** /F3>C /'\n'>C
		*strToBlock(F3, L2/L2, p)
		*** *printFComplex(F3/) /'\n'>C
		*** *HprintfBN(L2/) /'\n'>C
		*** S1=u /'S1 = '>C *printf(u/) /'\n'>C
		*** /'Q1 = '>C *printf(Q1/) /'\n'>C
		*** S2=u /'S2 = '>C *printf(u/) /'\n'>C
		*** /'Q2 = '>C *printf(Q2/) /'\n'>C
		Q2=Q1 *** от ошибки internal error на последнем шаге
		L2^L1=L2
		*blockToStr(L2, F3/F3, p)
		*** /F3>C /'\n'>C
		*fwritef(w, F3, 0, Q3/k)
		*** /'k = '>C *printf(k/) /'\n'>C
		?=1
	P2
**


fork(/p)
	{mov eax, 2}
	{int 80h}
	{mov [ebp+64],eax}
**


***	Создание файла с идентификатором процесса
***	p - pid
***	TODO: необходимо перед запуском вручную создать файл
***	
***	
setPidFile(p/)
	@+F1(100)
	@'/tmp/prak.pid'>F1
	*** /F1>C /'\n'>C
	*fopen(F1, 1/d)
	*** *printf(d/) /'\n'>C
	OQ1 *n2s(p, 10/F1)
	*fwritef(d, F1, 0, Q1/k)
	?(Q1=k)1 /'Something Wrong\n'>C
	P1
			*fclose(d/)
**


*** копирование одного числа из F1 в F2
*** e - признак окончания комплекса, а не встреча пробела
*** i - начало и конец итерации
readTillSpaceOrEnd(F1, i, j/F2, i, e)
	Oe Q1-1=w
	P1 ?(F1i=10)3 ?(F1i=32)3 ?(i>w)2 F1i=F2j Di Dj ?=1
	P2 De
	P3 Di j=Q2
**


*** Считать ключ из файла
*** F1 - название файла
*** k - количество обращений к X
readKeyFromFile(F1/k)
	@+F2(100)
	@+F3(100)
	*fopen(F1, 0/r) 99=q Ot=i=j=k=s
	
	P91
		OQ2 *freadf(r, F2, 0, q/p) p=Q2
		?(p>0)93 *s2n(F3, 10/n) ?(t>0)92 n=k ?=99
	P93
		*readTillSpaceOrEnd(F2, i, j/F3, i, e)
		?(e>0)94 *s2n(F3, 10/n) Oj=Q3 n=k ?=93
	P94
		Oi ?=91
	P99
		*** /'k = '>C *printf(k/) /'\n'>C
		*** /'s = '>C *printf(s/) /'\n'>C
		fclose(r/)
**


*** Может работать некорректно, если число не полностью попало в комплекс F2
*** Считать ключи из файла
*** F1 - название файла
*** k - количество обращений к X
*** s - размер файла
readKeysFromFile(F1/k, s)
	@+F2(100)
	@+F3(100)
	*fopen(F1, 0/r) 99=q Ot=i=j=k=s
	
	P91
		OQ2 *freadf(r, F2, 0, q/p) p=Q2
		?(p>0)93 *s2n(F3, 10/n) ?(t>0)92 n=k ?=99
	P93
		*readTillSpaceOrEnd(F2, i, j/F3, i, e)
		?(e>0)94 *s2n(F3, 10/n) Oj=Q3 ?(t>0)92 n=k Dt ?=93
	P94
		Oi ?=91
	P92
		n=s 
	P99
		*** /'k = '>C *printf(k/) /'\n'>C
		*** /'s = '>C *printf(s/) /'\n'>C
		fclose(r/)
**
