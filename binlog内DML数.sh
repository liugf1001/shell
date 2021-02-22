#!/bin/bash
file_name=33.sql
#统计BEGIN的行号
cat  -n $file_name |grep 'BEGIN'|awk '{print $1}'| sed ':label;N;s/\n/ /;b label' >no.txt
#将BEGIN行号转换成list
a=(`cat no.txt`)

#统计一共多少个事务，获取list下标，方便取出各事务开始对应的行号
c=`cat -n $file_name|grep 'BEGIN'|wc -l`
echo  "事务个数:$c"
for ((i=0;i<$c;i++))
do
	echo  '' >lol.txt
	no1=${a[$i]}

	j=$[$i+1]
	no_tmp=${a[$j]}
	no2=$[$no_tmp-1]
    if [ $no2 != -1 ];then 
	sed  -n  "$no1,$no2 p" $file_name>>lol.txt
	no_update=`cat  -n lol.txt|grep 'UPDATE'|wc -l`
	no_delete=`cat  -n lol.txt|grep 'DELETE'|wc -l`
	no_insert=`cat  -n lol.txt|grep 'INSERT'|wc -l`
	echo "$i BEGIN行号:$no1        update个数:$no_update        delete个数:$no_delete        insert个数:$no_insert  "
	echo  '' >lol.txt
    else
	d=`cat $file_name|wc -l`
	sed  -n  "$no1,$d p" $file_name>>lol.txt
	no_update=`cat  -n lol.txt|grep 'UPDATE'|wc -l`
        no_delete=`cat  -n lol.txt|grep 'DELETE'|wc -l`
        no_insert=`cat  -n lol.txt|grep 'INSERT'|wc -l`
	echo "$i BEGIN行号:$no1        update个数:$no_update        delete个数:$no_delete        insert个数:$no_insert  "
        echo  '' >lol.txt
    fi

done

echo "统计完成"

