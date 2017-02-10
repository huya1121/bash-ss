#!/bin/bash
cd ~
echo -e "\033[1;41m安装环境:\033[0m"
sleep 3
yum install -y vim wget
yum install -y python-setuptools && easy_install pip
yum install -y git
git clone -b manyuser https://github.com/shadowsocksr/shadowsocksr.git
echo -e "\033[1;51m下载ss文件成功，下面进行配置\033[0m"
cd shadowsocksr && cp apiconfig.py userapiconfig.py && chmod +x *.sh
sed -i 's/sspanelv2/mudbjson/' ~/shadowsocksr/userapiconfig.py
read -p "Enter your password: " PWD
read -p "Enter your port: " PORT
python mujson_mgr.py -a -u user -p $PORT -k $PWD -m aes-256-cfb > addlog
echo  '~/shadowsocksr/logrun.sh' >> /etc/rc.local
echo "添加自动启动成功！"
echo "ss启动服务成功,配置如下:"
echo -e "\033[1;31m`cat ~/shadowsocksr/addlog`\033[0m"
./logrun.sh
