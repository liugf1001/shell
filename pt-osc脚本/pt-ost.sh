#!/bin/bash
clear
ptostfun(){
		user=`cat  .user|grep "user"|cut -d ':' -f 2`
		pass=`cat  .user|grep "pass"|cut -d ':' -f 2`
		host=`cat  .user|grep "host"|cut -d ':' -f 2`
		port=`cat  .user|grep "port"|cut -d ':' -f 2`
		read -p "schema数据库名:" db
                read -p "table表名:" tb
                read -p "DDL内容:" alt
                echo -e "DDL语句为：\033[42;34malter table $db.$tb $alt ;\033[0m"
		echo "请另起窗口，查看log/pt-osc.log 日志观察进度"
		echo -e "\033[01m当前正在执行中。。。。。。\033[0m"
#                sleep 5
		echo "DDL语句为：alter table $db.$tb $alt ;">>log/pt-osc.log
		/data/pt/percona/bin/pt-online-schema-change  --user=$user  --password=$pass   --host=$host --port=$port      --alter="$alt" D=$db,t=$tb    --critical-load="Threads_running=300"       --chunk-size=800 --charset=utf8 --no-check-replication-filters --recursion-method=none  --execute  >>log/pt-osc.log
		if [ $? = 0  ];then
			echo "执行成功！！！！"
			echo "">.user	
		else
			echo "执行失败！！！！"
			echo "">.user
		fi
}

while true
do
echo "">.user
datee=`date +'%Y-%m-%d-%H:%M:%S'`
echo -e  '请选择数据库环境( \033[42;34mpre\033[0m:预发数据库  \033[42;34mscrm\033[0m:scrm数据库  \033[42;34mzilong\033[0m:zilong生产数据库   \033[42;34m0\033[0m:退出)' 
read  -p '输入选项：' name
case $name in 
	scrm)	echo -e  "你选择的是：\033[30;43mscrm\033[0m"
		cp .username/${name}user .user 
		echo "############# $datee" >>log/pt-osc.log
		echo "############# 你选择的环境为：$name " >>log/pt-osc.log
		ptostfun
		;;
	zilong) echo -e  "你选择的是：\033[30;43m  zilong  \033[0m"
		cp .username/${name}user .user 
		echo "############# $datee" >>log/pt-osc.log
		echo "############# 你选择的环境为：$name " >>log/pt-osc.log
		ptostfun
		;;
	
	pre)	echo -e  "你选择的是：\033[30;43m  pre  \033[0m"
		cp .username/${name}user .user
		echo "############# $datee" >>log/pt-osc.log
		echo "############# 你选择的环境为：$name " >>log/pt-osc.log
		ptostfun	
		;;
	
	0)       echo "结束程序"
		 break
	;;
	*)	 echo "输入错误,请重新输入"
	;;
esac
done
