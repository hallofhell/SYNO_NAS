# SYNO_NAS
群辉用docker版SSL申请+自动更新脚本
docker映像:neilpang-acme.sh1
挂载路径:/docker/任意新建文件夹          内部:/acme.sh
网络:勾选与host一致
环境变量添加如下:
域名解析服务商的API_Key和API_Secert，例如Ali_Key（各服务商用的名字不同，取得方法各异，请自行查找）
SYNO_Port:5000(默认5000，自定义的话记得要改）
SYNO_Username:(登陆群辉的用户名）
SYNO_Password:(登陆群辉用户名的密码）
SYNO_Certificate:""(""=空为替换默认证书）
SYNO_Create:"xxx.xx"(初次要为证书起名，否则会出错）
环境变量下方命令行输入:daemon
启动映像
将acme.sh脚本上传到任意文件夹（最好还是放入刚才新建的文件夹），在acme.sh上右键查看属性，复制文件地址
控制面板→任务计划→新增→起个任务名字方便记忆→用户账号一定要root→计划每月重复运行→任务设置→用户自定义脚本里加入bash /volume1/docker/acme/acme.sh >>/volume1/docker/acme/log/log.txt 2>&1
第一个是你自定义的脚本名称和路径，按需修改
第二个是/volume1/docker/acme/log/log.txt按需修改你想保存log的文件夹
设置完成后在新添加的计划上右键选择运行，查看log是否完成申请并自动部署好证书


自动更新停止时删除docker镜像重新安装，再次运行计划任务
