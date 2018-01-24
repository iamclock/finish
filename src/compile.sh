#! /bin/bash

# скрипт запускает транслятор со старых символов на новые файл name_.l
# затем компилирует выходной файл
# и удаляет промежуточные файлы .s _.l




if [ $# -eq 0 ]
	then
		echo -n "Enter file name by first argument: "
		#var file_name
		read file_name
else
	file_name=$1
fi
var=`basename $file_name .l`
#file_path=`dirname file_name`
#own_path=`dirname $0`
./for_compile/translator.py $file_name
./for_compile/ltc $var"_.l"
#if [ $ret -eq 0 ]
#	then
#		./for_compile/ltc $var"_.l"
#		rm $var"_.s" $var"_.l"
#else
#	echo "translator.py exit with errors"
#fi
rm $var"_.s" #$var"_.l"

