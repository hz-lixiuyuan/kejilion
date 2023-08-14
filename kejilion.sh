#!/bin/bash
while true; do
clear


echo -e "\033[96m_  _ ____  _ _ _    _ ____ _  _ "
echo "|_/  |___  | | |    | |  | |\ | "
echo "| \_ |___ _| | |___ | |__| | \| "
echo "                                "
echo -e "\033[96m科技lion一键脚本工具 v1.3 （该脚本仅支持Ubuntu和Debian系统）\033[0m"
echo "------------------------"
echo "1. 系统信息查询"
echo "2. 系统更新"
echo "3. 系统清理"
echo "4. 常用工具安装 ▶"
echo "5. BBR管理 ▶"
echo "6. Docker管理 ▶ "
echo "7. WARP管理 ▶ 解锁ChatGPT Netflix"
echo "8. 测试脚本合集 ▶ "
echo "9. 甲骨文云脚本合集 ▶ "
echo -e "\033[33m10. LDNMP建站 ▶ \033[0m"
echo "11. 常用面板工具 ▶ "
echo "12. 我的工作区 ▶ "
echo "------------------------"
echo "00. 脚本更新日志"   
echo "------------------------"
echo "0. 退出脚本"      
echo "------------------------"
read -p "请输入你的选择: " choice

case $choice in
  1)
  clear
  os_info=$(lsb_release -a 2>/dev/null | grep 'Description' | awk -F ':\t' '{print $2}')

  if [ "$(uname -m)" == "x86_64" ]; then
    cpu_info=$(cat /proc/cpuinfo | grep 'model name' | uniq | sed -e 's/model name[[:space:]]*: //')
  else
    cpu_info=$(lscpu | grep 'Model name' | sed -e 's/Model name[[:space:]]*: //')
  fi

  cpu_usage=$(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')
  cpu_usage_percent=$(printf "%.2f" $cpu_usage)%

  cpu_cores=$(nproc)

  mem_info=$(free -b | awk 'NR==2{printf "%.2f/%.2f MB (%.2f%%)", $3/1024/1024, $2/1024/1024, $3*100/$2}')

  disk_info=$(df -h | awk '$NF=="/"{printf "%d/%dGB (%s)", $3,$2,$5}')

  ipv4_address=$(curl -s4 ifconfig.co)
  ipv6_address=$(curl -s6 ifconfig.co)

  isp_info=$(curl -s ipinfo.io/org | sed -e 's/^[ \t]*//' | sed -e 's/\"//g')

  cpu_arch=$(uname -m)

  hostname=$(hostname)

  kernel_version=$(uname -r)

  echo ""
  echo "系统信息查询" 
  echo "------------------------"      
  echo "主机名: $hostname"
  echo "运营商: $isp_info"
  echo "------------------------"    
  echo "系统版本: $os_info"
  echo "Linux版本: $kernel_version"  
  echo "------------------------"    
  echo "CPU架构: $cpu_arch"
  echo "CPU型号: $cpu_info"
  echo "CPU核心数: $cpu_cores"
  echo "------------------------"  
  echo "CPU占用: $cpu_usage_percent"
  echo "内存占用: $mem_info"
  echo "硬盘占用: $disk_info"
  echo "------------------------"    
  echo "公网IPv4地址: $ipv4_address"
  echo "公网IPv6地址: $ipv6_address"
  echo

    ;;

  2)
    clear
    DEBIAN_FRONTEND=noninteractive apt update -y && DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
    ;;

  3)
    clear  
    apt autoremove --purge -y && apt clean -y && apt autoclean -y && apt remove --purge $(dpkg -l | awk '/^rc/ {print $2}') -y && journalctl --rotate && journalctl --vacuum-time=1s && journalctl --vacuum-size=50M && apt remove --purge $(dpkg -l | awk '/^ii linux-(image|headers)-[^ ]+/{print $2}' | grep -v $(uname -r | sed 's/-.*//') | xargs) -y
    ;;
  4)
     while true; do
      echo " ▼ "
      echo "安装常用工具"  
      echo "------------------------"      
      echo "1. curl 下载工具"
      echo "2. wget 下载工具"
      echo "3. sudo 超级管理权限工具"
      echo "4. socat 通信连接工具 （申请域名证书必备）"
      echo "5. htop 系统监控工具"
      echo "6. iftop 网络流量监控工具"      
      echo "7. unzip ZIP压缩解压工具z"
      echo "8. tar GZ压缩解压工具"
      echo "9. tmux 多路后台运行工具"
      echo "10. ffmpeg 视频编码直播推流工具"
      echo "------------------------"
      echo "31. 全部安装"    
      echo "32. 全部卸载"            
      echo "------------------------"
      echo "0. 返回主菜单"      
      echo "------------------------"
      read -p "请输入你的选择: " sub_choice
    
      case $sub_choice in
          1)
              clear
              apt update -y && apt install -y curl
              ;;
          2)
              clear
              apt update -y && apt install -y wget
              ;;
          3)
              clear
              apt update -y && apt install -y sudo
              ;;        
          4)
              clear
              apt update -y && apt install -y socat
              ;;        
          5)
              clear
              apt update -y && apt install -y htop
              ;;        
          6)
              clear
              apt update -y && apt install -y iftop
              ;;        
          7)
              clear
              apt update -y && apt install -y unzip
              ;;        
          8)
              clear
              apt update -y && apt install -y tar
              ;;        
          9)
              clear
              apt update -y && apt install -y tmux
              ;;        
          10)
              clear
              apt update -y && apt install -y ffmpeg
              ;;        

          31)
              clear
              apt update -y && apt install -y curl wget sudo socat htop iftop unzip tar tmux ffmpeg
              ;;        
          32)
              clear
              apt remove htop iftop unzip tmux ffmpeg
              ;;     
          0)
              /root/kejilion.sh
              exit
              ;;
          *)
              echo "无效的输入!"
              ;;
      esac
      echo -e "\033[0;32m操作完成\033[0m"
      echo "按任意键继续..."
      read -n 1 -s -r -p ""
      echo ""
      clear
    done
    ;;

  5)
    clear  
    apt update -y && apt install -y wget
    wget --no-check-certificate -O tcpx.sh https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcpx.sh
    chmod +x tcpx.sh
    ./tcpx.sh
    ;;

  6)
    while true; do
      echo " ▼ "
      echo "Docker管理器" 
      echo "------------------------"       
      echo "1. 安装更新Docker环境"
      echo "------------------------"
      echo "2. 查看Dcoker全局状态"
      echo "------------------------"     
      echo "3. Dcoker容器管理 ▶" 
      echo "4. Dcoker镜像管理 ▶"   
      echo "5. Dcoker网络管理 ▶" 
      echo "6. Dcoker卷管理 ▶"       
      echo "------------------------"                  
      echo "7. 清理无用的docker容器和镜像网络数据卷"
      echo "------------------------"
      echo "8. 卸载Dcoker环境"
      echo "------------------------"
      echo "0. 返回主菜单"      
      echo "------------------------"
      read -p "请输入你的选择: " sub_choice
    
      case $sub_choice in
          1)
              clear
              apt update -y
              curl -fsSL https://get.docker.com | sh
              curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose         
              ;;
          2)
              clear
              echo "Dcoker版本"
              docker --version
              docker-compose --version
              echo ""              
              echo "Dcoker镜像列表"
              docker image ls  
              echo ""              
              echo "Dcoker容器列表"
              docker ps -a  
              echo "" 
              echo "Dcoker卷列表"
              docker volume ls
              echo ""                                      
              echo "Dcoker网络列表"
              docker network ls                
              echo "" 
            
              ;;
          3)
              while true; do
                  clear
                  echo "Docker容器列表"
                  docker ps -a
                  echo ""
                  echo "容器操作"
                  echo "------------------------"                    
                  echo "1. 创建新的容器             11. 进入指定容器"
                  echo "------------------------"                  
                  echo "2. 启动指定容器             6. 启动所有容器"
                  echo "3. 停止指定容器             7. 暂停所有容器"
                  echo "4. 删除指定容器             8. 删除所有容器"
                  echo "5. 重启指定容器             9. 重启所有容器"
                  echo "------------------------"
                  echo "0. 返回上一级选单"
                  echo "------------------------"
                  read -p "请输入你的选择: " sub_choice

                  case $sub_choice in
                      1)
                          read -p "请输入创建命令：" dockername
                          $dockername
                          ;;  
                      11)
                          read -p "请输入容器名：" dockername
                          docker exec -it $dockername /bin/bash
                          ;;

                      # 11)
                      #     read -p "请输入项目名：" dockecomposername
                      #     mkdir -p /home/docker/$dockecomposername

                      #     read -p "输入创建目录命令：" chuangjianmulu
                      #     cd /home/docker/$dockecomposername && $chuangjianmulu

                      #     echo "任意键继续，编辑docker-compose.yml"
                      #     read -n 1 -s -r -p ""
                      #     cd /home/docker/$dockecomposername && nano docker-compose.yml

                      #     echo "任意键继续，运行docker-compose.yml"
                      #     cd /home/docker/$dockecomposername && docker-compose up -d
                      #     ;;

                      2)
                          read -p "请输入容器名：" dockername
                          docker start $dockername
                          ;;
                      3)
                          read -p "请输入容器名：" dockername
                          docker stop $dockername
                          ;;    
                      4)
                          read -p "请输入容器名：" dockername
                          docker rm -f $dockername
                          ;;   
                      5)
                          read -p "请输入容器名：" dockername
                          docker restart $dockername
                          ;;   
                      6)
                          docker start $(docker ps -a -q)
                          ;;                                                                                                       
                      7)
                          docker stop $(docker ps -q)
                          ;;     
                      8)
                          read -p "确定删除所有容器吗？(Y/N): " choice
                          case "$choice" in
                            [Yy])
                              docker rm -f $(docker ps -a -q)
                              ;;
                            [Nn])
                              ;;
                            *)
                              echo "无效的选择，请输入 Y 或 N。"
                              ;;
                          esac                            
                          ;;     
                      9)
                          docker restart $(docker ps -q)
                          ;;     
                      0)
                          break  # 跳出循环，退出菜单     
                          ;;

                      *)
                          break  # 跳出循环，退出菜单                              
                          ;;
                  esac
              done
              ;;        
          4)
              while true; do
                  clear
                  echo "Docker镜像列表"
                  docker image ls  
                  echo ""
                  echo "镜像操作"
                  echo "------------------------"                        
                  echo "1. 获取指定镜像             3. 删除指定镜像"
                  echo "2. 更新指定镜像             4. 删除所有镜像"
                  echo "------------------------"
                  echo "0. 返回上一级选单"
                  echo "------------------------"
                  read -p "请输入你的选择: " sub_choice

                  case $sub_choice in
                      1)
                          read -p "请输入镜像名：" dockername
                          docker pull $dockername
                          ;;
                      2)
                          read -p "请输入镜像名：" dockername
                          docker pull $dockername
                          ;;    
                      3)
                          read -p "请输入镜像名：" dockername
                          docker rmi -f $dockername
                          ;;   
                      4)
                          read -p "确定删除所有镜像吗？(Y/N): " choice
                          case "$choice" in
                            [Yy])
                              docker rmi -f $(docker images -q)
                              ;;
                            [Nn])

                              ;;
                            *)
                              echo "无效的选择，请输入 Y 或 N。"
                              ;;
                          esac                            
                          ;;     
                      0)
                          break  # 跳出循环，退出菜单
                          ;;

                      *)
                          break  # 跳出循环，退出菜单                          
                          ;;
                  esac
              done
              ;;        
             
          5)
              while true; do
                  clear
                  echo "Docker网络列表"
                  docker network ls      
                  echo ""
                  echo "网络操作"
                  echo "------------------------"                   
                  echo "1. 创建网络"
                  echo "2. 加入网络"                         
                  echo "3. 删除网络"           
                  echo "------------------------"
                  echo "0. 返回上一级选单"
                  echo "------------------------"
                  read -p "请输入你的选择: " sub_choice

                  case $sub_choice in
                      1)
                          read -p "设置新网络名：" dockernetwork
                          docker network create $dockernetwork
                          ;;
                      2)
                          read -p "加入网络名：" dockernetwork
                          read -p "那些容器加入该网络：" dockername                          
                          docker network connect $dockernetwork $dockername
                          ;;    
                      3)
                          read -p "请输入要删除的网络名：" dockernetwork
                          docker network rm $dockernetwork
                          ;;   
                      0)
                          break  # 跳出循环，退出菜单     
                          ;;

                      *)
                          break  # 跳出循环，退出菜单                             
                          ;;
                  esac
              done
              ;;        

          6)
              while true; do
                  clear
                  echo "Docker卷列表"
                  docker volume ls  
                  echo ""
                  echo "卷操作"
                  echo "------------------------"                      
                  echo "1. 创建新卷"                      
                  echo "2. 删除卷"           
                  echo "------------------------"
                  echo "0. 返回上一级选单"
                  echo "------------------------"
                  read -p "请输入你的选择: " sub_choice

                  case $sub_choice in
                      1)
                          read -p "设置新卷名：" dockerjuan
                          docker volume create $dockerjuan

                          ;;
                      2)
                          read -p "输入删除卷名：" dockerjuan
                          docker volume rm $dockerjuan

                          ;;    
                      0)
                          break  # 跳出循环，退出菜单     
                          ;;

                      *)
                          break  # 跳出循环，退出菜单                             
                          ;;
                  esac
              done
              ;;              
          7)
              clear
              read -p "确定清理无用的镜像容器网络吗？(Y/N): " choice
              case "$choice" in
                [Yy])
                  docker system prune -af --volumes       
                  ;;
                [Nn])                
                  ;;
                *)
                  echo "无效的选择，请输入 Y 或 N。"
                  ;;
              esac                       
              ;;        
          8)
              clear
              read -p "确定卸载docker环境吗？(Y/N): " choice
              case "$choice" in
                [Yy])
                  docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker network prune            
                  apt-get remove docker -y
                  apt-get remove docker-ce -y
                  apt-get purge docker-ce -y
                  rm -rf /var/lib/docker   
                  ;;
                [Nn])                
                  ;;
                *)
                  echo "无效的选择，请输入 Y 或 N。"
                  ;;
              esac   
              ;;                                    
          0)
              /root/kejilion.sh
              exit
              ;;
          *)
              echo "无效的输入!"
              ;;
      esac
      echo -e "\033[0;32m操作完成\033[0m"
      echo "按任意键继续..."
      read -n 1 -s -r -p ""
      echo ""
      clear
         
    done

    ;;


  7)
    clear  
    wget -N https://raw.githubusercontent.com/fscarmen/warp/main/menu.sh && bash menu.sh [option] [lisence]
    ;;


  8)
    while true; do

      echo " ▼ "
      echo "测试脚本合集"  
      echo "------------------------"      
      echo "1. ChatGPT解锁状态检测"
      echo "2. 流媒体解锁测试"
      echo "3. TikTok状态检测"
      echo "4. 三网回程延迟路由测试"
      echo "5. 三网回程线路测试"
      echo "6. 三网专项测速"
      echo "7. VPS性能专项测试"
      echo "8. VPS性能全局测试"
      echo "------------------------"
      echo "0. 返回主菜单"      
      echo "------------------------"
      read -p "请输入你的选择: " sub_choice
    
      case $sub_choice in
          1)
              clear
              bash <(curl -Ls https://cdn.jsdelivr.net/gh/missuo/OpenAI-Checker/openai.sh)
              ;;
          2)
              clear
              bash <(curl -L -s check.unlock.media)
              ;;
          3)
              clear
              wget -qO- https://github.com/yeahwu/check/raw/main/check.sh | bash
              ;;        
          4)
              clear
              wget -qO- git.io/besttrace | bash
              ;;        
          5)
              clear
              curl https://raw.githubusercontent.com/zhucaidan/mtr_trace/main/mtr_trace.sh | bash
              ;;        
          6)
              clear
              bash <(curl -Lso- https://git.io/superspeed_uxh)
              ;;        
          7)
              clear
              curl -sL yabs.sh | bash -s -- -i -5
              ;;        
          8)
              clear
              wget -qO- bench.sh | bash
              ;;        
          0)
              /root/kejilion.sh
              exit
              ;;
          *)
              echo "无效的输入!"
              ;;
      esac
      echo -e "\033[0;32m操作完成\033[0m"
      echo "按任意键继续..."
      read -n 1 -s -r -p ""
      echo ""
      clear
    done
    ;;

  9)  
     while true; do
      echo " ▼ "
      echo "甲骨文云脚本合集"  
      echo "------------------------"        
      echo "1. 安装闲置机器活跃脚本"
      echo "2. 卸载闲置机器活跃脚本"      
      echo "------------------------"      
      echo "3. DD重装系统脚本"
      echo "4. R探长开机脚本"
      echo "------------------------"
      echo "5. 开启ROOT密码登录模式" 
      echo "------------------------"           
      echo "0. 返回主菜单"      
      echo "------------------------"
      read -p "请输入你的选择: " sub_choice
    
      case $sub_choice in
          1)
              clear
              echo "活跃脚本：CPU占用10-20% 内存占用15% "
              read -p "确定安装吗？(Y/N): " choice
              case "$choice" in
                [Yy])
                  apt update -y
                  apt install -y curl
                  curl -fsSL https://get.docker.com | sh
                  docker run -itd --name=lookbusy --restart=always \
                          -e TZ=Asia/Shanghai \
                          -e CPU_UTIL=10-20 \
                          -e CPU_CORE=1 \
                          -e MEM_UTIL=15 \
                          -e SPEEDTEST_INTERVAL=120 \
                          fogforest/lookbusy
                  ;;
                [Nn])

                  ;;
                *)
                  echo "无效的选择，请输入 Y 或 N。"
                  ;;
              esac      
              ;;
          2)
              clear
              docker rm -f lookbusy 
              docker rmi fogforest/lookbusy
              ;;
          3)
          clear
          echo "请备份数据，将为你重装系统，预计花费15分钟。"
          read -p "确定继续吗？(Y/N): " choice

          case "$choice" in
            [Yy])
              while true; do
                read -p "请选择要重装的系统： 1. Debian12 | 2. Ubuntu20.04 : " sys_choice

                case "$sys_choice" in
                  1)
                    xitong="-d 12"
                    break  # 结束循环
                    ;;
                  2)
                    xitong="-u 20.04"
                    break  # 结束循环
                    ;;
                  *)
                    echo "无效的选择，请重新输入。"
                    ;;
                esac
              done
              
              read -p "请输入你重装后的密码：" vpspasswd
              apt update -y && apt install -y wget              
              bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') $xitong -v 64 -p $vpspasswd -port 22
              ;;
            [Nn])
              echo "已取消"
              ;;
            *)
              echo "无效的选择，请输入 Y 或 N。"
              ;;
          esac
              ;;      

          4)
              clear
              echo "该功能处于开发阶段，敬请期待！"  
              ;; 
          5)
              clear        
              echo "设置你的ROOT密码"
              passwd
              sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
              sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
              sudo service sshd restart 
              echo "ROOT登录设置完毕！"
              read -p "需要重启服务器吗？(Y/N): " choice
          case "$choice" in
            [Yy])
              reboot
              ;;
            [Nn])
              echo "已取消"
              ;;
            *)
              echo "无效的选择，请输入 Y 或 N。"
              ;;
          esac              
              ;;                                  
          0)
              /root/kejilion.sh
              exit
              ;;
          *)
              echo "无效的输入!"
              ;;
      esac
      echo -e "\033[0;32m操作完成\033[0m"
      echo "按任意键继续..."
      read -n 1 -s -r -p ""
      echo ""
      clear
    done
    ;;


  10)

  while true; do  
    echo -e "\033[33m ▼ \033[0m"
    echo -e "\033[33mLDNMP建站\033[0m"
    echo  "------------------------"  
    echo  "1. 安装LDNMP环境"
    echo  "------------------------"
    echo  "2. 安装WordPress"
    echo  "3. 安装Discuz论坛"
    echo  "4. 安装可道云桌面"
    echo  "5. 安装苹果CMS网站"
    echo  "6. 安装独角数发卡网"
    echo  "------------------------"
    echo  "21. 站点重定向"
    echo  "22. 站点反向代理"
    echo  "------------------------"
    echo  "30. 仅申请证书"
    echo  "------------------------"    
    echo  "31. 查看当前站点信息"
    echo  "32. 备份全站数据"
    echo  "33. 还原全站数据"
    echo  "34. 卸载LDNMP环境"
    echo  "------------------------"
    echo  "0. 返回主菜单"          
    echo  "------------------------"    
    read -p "请输入你的选择: " sub_choice

    
    case $sub_choice in
      1)
      clear
      # 获取用户输入，用于替换 docker-compose.yml 文件中的占位符
      read -p "设置数据库ROOT密码：" dbrootpasswd
      read -p "设置数据库用户名：" dbuse
      read -p "设置数据库用户密码：" dbusepasswd
      
      
      # 更新并安装必要的软件包
      DEBIAN_FRONTEND=noninteractive apt update -y
      DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
      apt install -y curl wget sudo socat unzip tar htop
      
      # 安装 Docker
      curl -fsSL https://get.docker.com | sh
      
      # 安装 Docker Compose
      curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
      
      # 创建必要的目录和文件
      cd /home && mkdir -p web/html web/mysql web/certs web/conf.d web/redis && touch web/docker-compose.yml
      
      # 下载 docker-compose.yml 文件并进行替换
      wget -O /home/web/docker-compose.yml https://raw.githubusercontent.com/kejilion/docker/main/LNMP-docker-compose-4.yml
           
      # 在 docker-compose.yml 文件中进行替换
      sed -i "s/webroot/$dbrootpasswd/g" /home/web/docker-compose.yml
      sed -i "s/kejilionYYDS/$dbusepasswd/g" /home/web/docker-compose.yml
      sed -i "s/kejilion/$dbuse/g" /home/web/docker-compose.yml
      
      iptables -P INPUT ACCEPT
      iptables -P FORWARD ACCEPT
      iptables -P OUTPUT ACCEPT
      iptables -F
      
      cd /home/web && docker-compose up -d
      
      docker exec php apt update &&
      docker exec php apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick &&
      docker exec php docker-php-ext-install mysqli pdo_mysql zip exif gd intl bcmath opcache &&
      docker exec php pecl install imagick &&
      docker exec php sh -c 'echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini' &&
      docker exec php pecl install redis &&
      docker exec php sh -c 'echo "extension=redis.so" > /usr/local/etc/php/conf.d/docker-php-ext-redis.ini' &&
      docker exec php sh -c 'echo "upload_max_filesize=50M \n post_max_size=50M" > /usr/local/etc/php/conf.d/uploads.ini' &&
      docker exec php sh -c 'echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory.ini'
      docker exec php sh -c 'echo "max_execution_time=120" > /usr/local/etc/php/conf.d/max_execution_time.ini'
      
      
      docker exec php74 apt update &&
      docker exec php74 apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick &&
      docker exec php74 docker-php-ext-install mysqli pdo_mysql zip gd intl bcmath opcache &&
      docker exec php74 pecl install imagick &&
      docker exec php74 sh -c 'echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini' &&
      docker exec php74 pecl install redis &&
      docker exec php74 sh -c 'echo "extension=redis.so" > /usr/local/etc/php/conf.d/docker-php-ext-redis.ini' &&
      docker exec php74 sh -c 'echo "upload_max_filesize=50M \n post_max_size=50M" > /usr/local/etc/php/conf.d/uploads.ini' &&
      docker exec php74 sh -c 'echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory.ini'
      docker exec php74 sh -c 'echo "max_execution_time=120" > /usr/local/etc/php/conf.d/max_execution_time.ini'
      
        ;;
      2)
      clear
      # wordpress
      read -p "请输入你解析的域名：" yuming
      read -p "设置新数据库名称：" dbname
      
      docker stop nginx
      
      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force
      
      docker start nginx
      
      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/wordpress.com.conf
      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      
      cd /home/web/html
      mkdir $yuming
      cd $yuming
      wget https://cn.wordpress.org/wordpress-6.3-zh_CN.zip
      unzip wordpress-6.3-zh_CN.zip
      rm wordpress-6.3-zh_CN.zip
      
      echo "define('FS_METHOD', 'direct'); define('WP_REDIS_HOST', 'redis'); define('WP_REDIS_PORT', '6379');" >> /home/web/html/$yuming/wordpress/wp-config-sample.php
      
      docker exec nginx chmod -R 777 /var/www/html && docker exec php chmod -R 777 /var/www/html && docker exec php74 chmod -R 777 /var/www/html
            
      dbrootpasswd=$(grep -oP 'MYSQL_ROOT_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbuse=$(grep -oP 'MYSQL_USER:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbusepasswd=$(grep -oP 'MYSQL_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')      
      docker exec mysql mysql -u root -p"$dbrootpasswd" -e "CREATE DATABASE $dbname; GRANT ALL PRIVILEGES ON $dbname.* TO \"$dbuse\"@\"%\";"

      docker restart php && docker restart php74 && docker restart nginx

      clear  
      echo "您的WordPress搭建好了！"
      echo "https://$yuming"
      echo ""  
      echo "WP安装信息如下："  
      echo "数据库名：$dbname"
      echo "用户名：$dbuse"
      echo "密码：$dbusepasswd"
      echo "数据库主机：mysql"  
      echo "表前缀：$dbname"  

        ;;
      3)
      clear
      # Discuz论坛
      read -p "请输入你解析的域名：" yuming
      read -p "设置新数据库名称：" dbname
      
      docker stop nginx
      
      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force
      
      docker start nginx
      
      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/discuz.com.conf

      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      
      cd /home/web/html
      mkdir $yuming
      cd $yuming
      wget https://github.com/kejilion/Website_source_code/raw/main/Discuz_X3.5_SC_UTF8_20230520.zip
      unzip -o Discuz_X3.5_SC_UTF8_20230520.zip
      rm Discuz_X3.5_SC_UTF8_20230520.zip      
            
      docker exec nginx chmod -R 777 /var/www/html && docker exec php chmod -R 777 /var/www/html && docker exec php74 chmod -R 777 /var/www/html      
      
      dbrootpasswd=$(grep -oP 'MYSQL_ROOT_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbuse=$(grep -oP 'MYSQL_USER:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbusepasswd=$(grep -oP 'MYSQL_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')      
      docker exec mysql mysql -u root -p"$dbrootpasswd" -e "CREATE DATABASE $dbname; GRANT ALL PRIVILEGES ON $dbname.* TO \"$dbuse\"@\"%\";"
            
      docker restart php && docker restart php74 && docker restart nginx


      clear     
      echo "您的Discuz论坛搭建好了！"
      echo "https://$yuming"
      echo ""  
      echo "安装信息如下："  
      echo "数据库主机：mysql"  
      echo "数据库名：$dbname"
      echo "用户名：$dbuse"
      echo "密码：$dbusepasswd"
      echo "表前缀：$dbname"  

        ;;

      4)
      clear
      # 可道云桌面
      read -p "请输入你解析的域名：" yuming
      read -p "设置新数据库名称：" dbname
      
      docker stop nginx
      
      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force
      
      docker start nginx
      
      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/kdy.com.conf

      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      
      cd /home/web/html
      mkdir $yuming
      cd $yuming
      wget https://github.com/kalcaddle/kodbox/archive/refs/tags/1.42.04.zip
      unzip -o 1.42.04.zip
      rm 1.42.04.zip
            
      docker exec nginx chmod -R 777 /var/www/html && docker exec php chmod -R 777 /var/www/html && docker exec php74 chmod -R 777 /var/www/html
            
      dbrootpasswd=$(grep -oP 'MYSQL_ROOT_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbuse=$(grep -oP 'MYSQL_USER:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbusepasswd=$(grep -oP 'MYSQL_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')      
      docker exec mysql mysql -u root -p"$dbrootpasswd" -e "CREATE DATABASE $dbname; GRANT ALL PRIVILEGES ON $dbname.* TO \"$dbuse\"@\"%\";"

      docker restart php && docker restart php74 && docker restart nginx


      clear      
      echo "您的可道云桌面搭建好了！"
      echo "https://$yuming"
      echo ""  
      echo "安装信息如下："  
      echo "数据库主机：mysql"  
      echo "用户名：$dbuse"
      echo "密码：$dbusepasswd"
      echo "数据库名：$dbname"

        ;;
      5)
      clear
      # 可道云桌面
      read -p "请输入你解析的域名：" yuming
      read -p "设置新数据库名称：" dbname
      
      docker stop nginx
      
      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force
      
      docker start nginx
      
      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/maccms.com.conf

      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      
      cd /home/web/html
      mkdir $yuming
      cd $yuming
      wget https://github.com/magicblack/maccms_down/raw/master/maccms10.zip && unzip maccms10.zip && rm maccms10.zip
      cd /home/web/html/$yuming/maccms10-master/template/ && wget https://github.com/kejilion/Website_source_code/raw/main/DYXS2.zip && unzip DYXS2.zip && rm /home/web/html/$yuming/maccms10-master/template/DYXS2.zip 
      cp /home/web/html/$yuming/maccms10-master/template/DYXS2/asset/admin/Dyxs2.php /home/web/html/$yuming/maccms10-master/application/admin/controller 
      cp /home/web/html/$yuming/maccms10-master/template/DYXS2/asset/admin/dycms.html /home/web/html/$yuming/maccms10-master/application/admin/view/system
      mv /home/web/html/$yuming/maccms10-master/admin.php /home/web/html/$yuming/maccms10-master/vip.php && wget -O /home/web/html/$yuming/maccms10-master/application/extra/maccms.php https://raw.githubusercontent.com/kejilion/Website_source_code/main/maccms.php
            
      docker exec nginx chmod -R 777 /var/www/html && docker exec php chmod -R 777 /var/www/html && docker exec php74 chmod -R 777 /var/www/html
            
      dbrootpasswd=$(grep -oP 'MYSQL_ROOT_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbuse=$(grep -oP 'MYSQL_USER:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbusepasswd=$(grep -oP 'MYSQL_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')      
      docker exec mysql mysql -u root -p"$dbrootpasswd" -e "CREATE DATABASE $dbname; GRANT ALL PRIVILEGES ON $dbname.* TO \"$dbuse\"@\"%\";"

      docker restart php && docker restart php74 && docker restart nginx


      clear      
      echo "您的苹果CMS搭建好了！"
      echo "https://$yuming"
      echo ""  
      echo "安装信息如下："  
      echo "数据库主机：mysql"  
      echo "数据库端口：3306"        
      echo "数据库名：$dbname"      
      echo "用户名：$dbuse"
      echo "密码：$dbusepasswd"
      echo "数据库前缀：mac"    
      echo ""        
      echo "安装成功后登录后台地址"    
      echo "https://$yuming/vip.php"
      echo ""  
        ;;   
           
      6)
      clear
      # 独脚数卡
      read -p "请输入你解析的域名：" yuming
      read -p "设置新数据库名称：" dbname
      
      docker stop nginx
      
      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force
      
      docker start nginx
      
      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/dujiaoka.com.conf

      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      
      cd /home/web/html
      mkdir $yuming
      cd $yuming
      wget https://github.com/assimon/dujiaoka/releases/download/2.0.6/2.0.6-antibody.tar.gz && tar -zxvf 2.0.6-antibody.tar.gz && rm 2.0.6-antibody.tar.gz
            
      docker exec nginx chmod -R 777 /var/www/html && docker exec php chmod -R 777 /var/www/html && docker exec php74 chmod -R 777 /var/www/html
            
      dbrootpasswd=$(grep -oP 'MYSQL_ROOT_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbuse=$(grep -oP 'MYSQL_USER:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')
      dbusepasswd=$(grep -oP 'MYSQL_PASSWORD:\s*\K.*' /home/web/docker-compose.yml | tr -d '[:space:]')      
      docker exec mysql mysql -u root -p"$dbrootpasswd" -e "CREATE DATABASE $dbname; GRANT ALL PRIVILEGES ON $dbname.* TO \"$dbuse\"@\"%\";"

      docker restart php && docker restart php74 && docker restart nginx


      clear      
      echo "您的独角数卡网站搭建好了！"
      echo "https://$yuming"
      echo ""  
      echo "安装信息如下："  
      echo "数据库主机：mysql"  
      echo "数据库端口：3306"        
      echo "数据库名：$dbname"      
      echo "用户名：$dbuse"
      echo "密码：$dbusepasswd"
      echo "数据库前缀：mac"    
      echo ""        
      echo "redis地址：redis"  
      echo "redis密码：默认不填写"
      echo "redis端口：6379"        
      echo ""
      echo "网站url：https://$yuming"      
      echo "后台登录路径：/admin" 
      echo ""           
        ;;      

      21)
      clear
      read -p "请输入你的域名：" yuming
      read -p "请输入跳转域名：" reverseproxy

      docker stop nginx

      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force

      docker start nginx

      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/rewrite.conf
      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      sed -i "s/baidu.com/$reverseproxy/g" /home/web/conf.d/$yuming.conf

      docker restart php && docker restart php74 && docker restart nginx
      
      clear  
      echo "您的重定向网站做好了！"
      echo "https://$yuming"

        ;;

      22)
      clear
      read -p "请输入你的域名：" yuming
      read -p "请输入你的反代IP：" reverseproxy
      read -p "请输入你的反代端口：" port

      docker stop nginx

      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force

      docker start nginx

      wget -O /home/web/conf.d/$yuming.conf https://raw.githubusercontent.com/kejilion/nginx/main/reverse-proxy.conf
      sed -i "s/yuming.com/$yuming/g" /home/web/conf.d/$yuming.conf
      sed -i "s/0.0.0.0/$reverseproxy/g" /home/web/conf.d/$yuming.conf
      sed -i "s/0000/$port/g" /home/web/conf.d/$yuming.conf

      docker restart php && docker restart php74 && docker restart nginx
      
      clear  
      echo "您的反向代理网站做好了！"
      echo "https://$yuming"

        ;;


    30)
      clear
      read -p "请输入你解析的域名：" yuming
      
      docker stop nginx
      
      curl https://get.acme.sh | sh
      ~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com --issue -d $yuming --standalone --key-file /home/web/certs/${yuming}_key.pem --cert-file /home/web/certs/${yuming}_cert.pem --force
      
      docker start nginx

      ;;


    31)
    clear
    ls /home/web/conf.d
      ;;


    32)
      clear
      cd /home/ && tar czvf web_$(date +"%Y%m%d%H%M%S").tar.gz web
    
      while true; do
        clear  
        read -p "要传送文件到远程服务器吗？(Y/N): " choice
        case "$choice" in
          [Yy])
            read -p "请输入远端服务器IP： " remote_ip
            if [ -z "$remote_ip" ]; then
              echo "错误：请输入远端服务器IP。"
              continue
            fi
            latest_tar=$(ls -t /home/*.tar.gz | head -1)
            if [ -n "$latest_tar" ]; then
              ssh-keygen -f "/root/.ssh/known_hosts" -R "$remote_ip"
              sleep 2  # 添加等待时间
              scp "$latest_tar" "root@$remote_ip:/home/"
              echo "文件已传送至远程服务器home目录。"
            else
              echo "未找到要传送的文件。"
            fi
            break
            ;;
          [Nn])
            break
            ;;
          *)
            echo "无效的选择，请输入 Y 或 N。"
            ;;
        esac
      done
      ;;

    33)
      clear
      cd /home/ && ls -t /home/*.tar.gz | head -1 | xargs -I {} tar -xzf {}   
      
      cd /home/web && docker-compose up -d      
      
      docker exec php apt update &&
      docker exec php apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick &&
      docker exec php docker-php-ext-install mysqli pdo_mysql zip exif gd intl bcmath opcache &&
      docker exec php pecl install imagick &&
      docker exec php sh -c 'echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini' &&
      docker exec php pecl install redis &&
      docker exec php sh -c 'echo "extension=redis.so" > /usr/local/etc/php/conf.d/docker-php-ext-redis.ini' &&
      docker exec php sh -c 'echo "upload_max_filesize=50M \n post_max_size=50M" > /usr/local/etc/php/conf.d/uploads.ini' &&
      docker exec php sh -c 'echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory.ini'
      
      
      docker exec php74 apt update &&
      docker exec php74 apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick &&
      docker exec php74 docker-php-ext-install mysqli pdo_mysql zip gd intl bcmath opcache &&
      docker exec php74 pecl install imagick &&
      docker exec php74 sh -c 'echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini' &&
      docker exec php74 pecl install redis &&
      docker exec php74 sh -c 'echo "extension=redis.so" > /usr/local/etc/php/conf.d/docker-php-ext-redis.ini' &&
      docker exec php74 sh -c 'echo "upload_max_filesize=50M \n post_max_size=50M" > /usr/local/etc/php/conf.d/uploads.ini' &&
      docker exec php74 sh -c 'echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory.ini'

      docker exec nginx chmod -R 777 /var/www/html && docker exec php chmod -R 777 /var/www/html && docker exec php74 chmod -R 777 /var/www/html
      docker restart php && docker restart php74 && docker restart nginx
     
      ;;


    34)
        clear
        read -p "强烈建议先备份全部网站数据，再卸载LDNMP环境。确定删除所有网站数据吗？(Y/N): " choice
        case "$choice" in
          [Yy])
            docker rm -f nginx
            docker rm -f php
            docker rm -f php74
            docker rm -f mysql
            docker rm -f redis
            docker system prune -af --volumes
            rm -r /home/web
            ;;
          [Nn])
          
            ;;
          *)
            echo "无效的选择，请输入 Y 或 N。"
            ;;
        esac    
        ;;

    0)
    /root/kejilion.sh
    exit
      ;;

    *)
        echo "无效的输入!"
    esac
  
    echo -e "\033[0;32m操作完成\033[0m"
    echo "按任意键继续..."
    read -n 1 -s -r -p ""
    echo ""
    clear    
  done      
      ;;

  11)
    while true; do

      echo " ▼ "
      echo "常用面板工具"
      echo "------------------------"      
      echo "1. 宝塔面板官方版"
      echo "2. aaPanel宝塔国际版"
      echo "3. 1Panel新一代管理面板"
      echo "4. Nginx Proxy Manager NGINX可视化面板"
      echo "5. 哪吒探针VPS监控面板"
      echo "------------------------"
      echo "0. 返回主菜单"      
      echo "------------------------"
      read -p "请输入你的选择: " sub_choice
    
      case $sub_choice in
          1)
            clear
            echo "安装提示"             
            echo "如果您已经安装了其他面板工具或者LDNMP建站环境，建议先卸载，再安装宝塔面板！"
            echo "会根据系统自动安装，支持Debian，Ubuntu，Centos" 
            echo "官网介绍：https://www.bt.cn/new/index.html" 
            echo ""                 
            # 获取当前系统类型
            get_system_type() {
              if [ -f /etc/os-release ]; then
                . /etc/os-release
                if [ "$ID" == "centos" ]; then
                  echo "centos"
                elif [ "$ID" == "ubuntu" ]; then
                  echo "ubuntu"
                elif [ "$ID" == "debian" ]; then
                  echo "debian"
                else
                  echo "unknown"
                fi
              else
                echo "unknown"
              fi
            }

            system_type=$(get_system_type)

            if [ "$system_type" == "unknown" ]; then
              echo "不支持的操作系统类型"
            else
              read -p "确定安装宝塔吗？(Y/N): " choice
              case "$choice" in
                [Yy])
                  if [ "$system_type" == "centos" ]; then
                    yum install -y wget && wget -O install.sh https://download.bt.cn/install/install_6.0.sh && sh install.sh ed8484bec
                  elif [ "$system_type" == "ubuntu" ]; then
                    wget -O install.sh https://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash install.sh ed8484bec
                  elif [ "$system_type" == "debian" ]; then
                    wget -O install.sh https://download.bt.cn/install/install-ubuntu_6.0.sh && bash install.sh ed8484bec
                  fi
                  ;;
                [Nn])
                  ;;
                *)
                  ;;
              esac
            fi 
              ;;
          2)
            clear
            echo "安装提示"             
            echo "如果您已经安装了其他面板工具或者LDNMP建站环境，建议先卸载，再安装aaPanel！"
            echo "会根据系统自动安装，支持Debian，Ubuntu，Centos"   
            echo "官网介绍：https://www.aapanel.com/new/index.html"   
            echo ""                        
            # 获取当前系统类型
            get_system_type() {
              if [ -f /etc/os-release ]; then
                . /etc/os-release
                if [ "$ID" == "centos" ]; then
                  echo "centos"
                elif [ "$ID" == "ubuntu" ]; then
                  echo "ubuntu"
                elif [ "$ID" == "debian" ]; then
                  echo "debian"
                else
                  echo "unknown"
                fi
              else
                echo "unknown"
              fi
            }

            system_type=$(get_system_type)

            if [ "$system_type" == "unknown" ]; then
              echo "不支持的操作系统类型"
            else
              read -p "确定安装aaPanel吗？(Y/N): " choice
              case "$choice" in
                [Yy])
                  if [ "$system_type" == "centos" ]; then
                    yum install -y wget && wget -O install.sh http://www.aapanel.com/script/install_6.0_en.sh && bash install.sh aapanel
                  elif [ "$system_type" == "ubuntu" ]; then
                    wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh aapanel
                  elif [ "$system_type" == "debian" ]; then
                    wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && bash install.sh aapanel
                  fi
                  ;;
                [Nn])
                  ;;
                *)
                  ;;
              esac
            fi 
              ;;
          3)
            clear
            echo "安装提示"             
            echo "如果您已经安装了其他面板工具或者LDNMP建站环境，建议先卸载，再安装1Panel！"
            echo "会根据系统自动安装，支持Debian，Ubuntu，Centos" 
            echo "官网介绍：https://1panel.cn/"   
            echo ""                                 
            # 获取当前系统类型
            get_system_type() {
              if [ -f /etc/os-release ]; then
                . /etc/os-release
                if [ "$ID" == "centos" ]; then
                  echo "centos"
                elif [ "$ID" == "ubuntu" ]; then
                  echo "ubuntu"
                elif [ "$ID" == "debian" ]; then
                  echo "debian"
                else
                  echo "unknown"
                fi
              else
                echo "unknown"
              fi
            }

            system_type=$(get_system_type)

            if [ "$system_type" == "unknown" ]; then
              echo "不支持的操作系统类型"
            else
              read -p "确定安装1Panel吗？(Y/N): " choice
              case "$choice" in
                [Yy])
                  if [ "$system_type" == "centos" ]; then
                    curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && sh quick_start.sh
                  elif [ "$system_type" == "ubuntu" ]; then
                    curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && sudo bash quick_start.sh
                  elif [ "$system_type" == "debian" ]; then
                    curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && bash quick_start.sh
                  fi
                  ;;
                [Nn])
                  ;;
                *)
                  ;;
              esac
            fi 
              ;;
          4)            
            # Function to get external IP address
            get_external_ip() {
              curl -s ifconfig.me
            }
            clear            
            echo "安装提示" 
            echo "如果您已经安装了其他面板工具或者LDNMP建站环境，建议先卸载，再安装npm！"
            echo "官网介绍：https://nginxproxymanager.com/" 
            echo ""
            
            # Prompt user for installation confirmation
            read -p "确定安装npm吗？(Y/N): " choice
            case "$choice" in
              [Yy])
                clear
                apt update -y && apt install -y curl
                curl -fsSL https://get.docker.com | sh
                docker run -d \
                  --name=npm \
                  -p 80:80 \
                  -p 81:81 \
                  -p 443:443 \
                  -v /home/npm/data:/data \
                  -v /home/npm/letsencrypt:/etc/letsencrypt \
                  --restart=always \
                  jc21/nginx-proxy-manager:latest
                clear
                echo "npm已经安装完成"
                
                # Get external IP address
                external_ip=$(get_external_ip)
                
                echo "您可以使用以下地址访问Nginx Proxy Manager:"
                echo "$external_ip:81"                            
                echo "初始用户名：admin@example.com"  
                echo "初始密码：changeme" 
                ;;
              [Nn])
                ;;
              *)
                ;;
            esac            
              ;;

          0)
              /root/kejilion.sh
              exit
              ;;
          *)
              echo "无效的输入!"
              ;;
      esac
      echo -e "\033[0;32m操作完成\033[0m"
      echo "按任意键继续..."
      read -n 1 -s -r -p ""
      echo ""
      clear
    done
    ;;

  12)
    while true; do
      echo " ▼ "
      echo "我的工作区" 
      echo "系统将为你提供5个后台运行的工作区，你可以用来执行长时间的任务"  
      echo "即使你断开SSH，工作区中的任务也不会中断，非常方便！来试试吧！"               
      echo -e "\033[33m注意：进入工作区后使用Ctrl+b再单独按d，退出工作区！\033[0m"             
      echo "------------------------"      
      echo "a. 安装工作区环境"
      echo "------------------------"       
      echo "1. 1号工作区"
      echo "2. 2号工作区"
      echo "3. 3号工作区"
      echo "4. 4号工作区"
      echo "5. 5号工作区"
      echo "------------------------"      
      echo "8. 工作区状态"   
      echo "------------------------"
      echo "0. 返回主菜单"      
      echo "------------------------"
      read -p "请输入你的选择: " sub_choice
    
      case $sub_choice in
          a)
              clear
              apt update -y && apt install -y tmux
              ;;
          1)
              clear
              SESSION_NAME="work1"

              # Check if the session already exists
              tmux has-session -t $SESSION_NAME 2>/dev/null

              # $? is a special variable that holds the exit status of the last executed command
              if [ $? != 0 ]; then
                # Session doesn't exist, create a new one
                tmux new -s $SESSION_NAME
              else
                # Session exists, attach to it
                tmux attach-session -t $SESSION_NAME
              fi 
              ;;
          2)
              clear
              SESSION_NAME="work2"

              # Check if the session already exists
              tmux has-session -t $SESSION_NAME 2>/dev/null

              # $? is a special variable that holds the exit status of the last executed command
              if [ $? != 0 ]; then
                # Session doesn't exist, create a new one
                tmux new -s $SESSION_NAME
              else
                # Session exists, attach to it
                tmux attach-session -t $SESSION_NAME
              fi 
              ;;
          3)
              clear
              SESSION_NAME="work3"

              # Check if the session already exists
              tmux has-session -t $SESSION_NAME 2>/dev/null

              # $? is a special variable that holds the exit status of the last executed command
              if [ $? != 0 ]; then
                # Session doesn't exist, create a new one
                tmux new -s $SESSION_NAME
              else
                # Session exists, attach to it
                tmux attach-session -t $SESSION_NAME
              fi 
              ;;
          4)
              clear
              SESSION_NAME="work4"

              # Check if the session already exists
              tmux has-session -t $SESSION_NAME 2>/dev/null

              # $? is a special variable that holds the exit status of the last executed command
              if [ $? != 0 ]; then
                # Session doesn't exist, create a new one
                tmux new -s $SESSION_NAME
              else
                # Session exists, attach to it
                tmux attach-session -t $SESSION_NAME
              fi 
              ;;
          5)
              clear
              SESSION_NAME="work4"

              # Check if the session already exists
              tmux has-session -t $SESSION_NAME 2>/dev/null

              # $? is a special variable that holds the exit status of the last executed command
              if [ $? != 0 ]; then
                # Session doesn't exist, create a new one
                tmux new -s $SESSION_NAME
              else
                # Session exists, attach to it
                tmux attach-session -t $SESSION_NAME
              fi 
              ;;

          8)
              clear
              tmux list-sessions
              ;;
          0)
              /root/kejilion.sh
              exit
              ;;
          *)
              echo "无效的输入!"
              ;;
      esac
      echo -e "\033[0;32m操作完成\033[0m"
      echo "按任意键继续..."
      read -n 1 -s -r -p ""
      echo ""
      clear
    done
    ;;



  00)
    clear
    echo "脚本更新日志" 
    echo "2023-8-14   v1.3" 
    echo "新增了12选项，我的工作区功能"
    echo "-将为你提供5个后台运行的工作区，用来执行后台任务。即使你断开SSH也不会中断，"    
    echo "-非常有意思的功能，快去试试吧！"   
    echo  "------------------------"         
    echo "2023-8-14   v1.2" 
    echo "1.新增了11选项，加入了常用面板工具合集！"
    echo "-支持安装各种面板，包括：宝塔，宝塔国际版，1panel，Nginx Proxy Manager等等，满足更多人群的使用需求！"    
    echo "2.优化了菜单效果"          
    echo  "------------------------"    
    echo "2023-8-14   v1.1" 
    echo "Docker管理器全面升级，体验前所未有！"
    echo "-加入了docker容器管理面板" 
    echo "-加入了docker镜像管理面板"   
    echo "-加入了docker网络管理面板"  
    echo "-加入了docker卷管理面板"           
    echo "-删除docker时追加确认信息，拒绝误操作"           
    echo  "------------------------"    
    echo "2023-8-13   v1.0.4" 
    echo "1.LDNMP建站，开放了独角数卡网站的搭建功能."
    echo "2.LDNMP建站，优化了备份全站到远端服务器的稳定性."
    echo "3.Docker管理，全局状态信息，添加了所有docker卷的显示."    
    echo  "------------------------"
    echo "2023-8-13   v1.0.3" 
    echo "1.甲骨文云的DD脚本，添加了Ubuntu 20.04的重装选项。"
    echo "2.LDNMP建站，开放了苹果CMS网站的搭建功能."    
    echo "3.系统信息查询，增加了内核版本显示，美化了界面。"
    echo "4.甲骨文脚本中，添加了开启ROOT登录的选项。"
    echo ""
    ;;


  0)
    clear
    exit
    ;;

  *)
    echo "无效的输入!"

esac
  echo -e "\033[0;32m操作完成\033[0m"
  echo "按任意键继续..."
  read -n 1 -s -r -p ""
  echo ""
  clear
done
