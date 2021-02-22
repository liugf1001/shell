1.确认pt-online-schema-table绝对路径
2.确认.username/目录下对应的文件：提供账号密码等连接信息
		格式如下：
[root@rp-hb2-jumper-01 soft]# tree -a
.
├── log---------------日志目录(记得创建 mkdir log)
│   └── pt-osc.log----日志文件
├── ptosc-------------当不使用工具时，将连接信息文件mv到当前目录下，当使用工具时，mv到soft目录下（mv ptosc/.username .）
│   └── .username
│       ├── preuser---预发数据库用户数据库文件
│       ├── scrmuser--scrm数据库用户信息文件
│       └── zilonguser-子龙数据库用户信息文件
├── pt-ost.sh----------实际执行文件，sh pt-ost.sh
└── .user--------------过度文件，使用完工具后记得清空(echo "">.user)
		
preuser---文件名
		user:user
		port:3336
		pass:pass
		host:host


3.执行步骤：
cd /data/pt/soft/
mv ptosc/.username .
sh pt-ost.sh
mv .username ptosc/
echo "">.user
