#Version:	0.0.1
#使用的blink版本暂时只能在14.04上编译
#基于Ubuntu 14.04镜像
FROM ubuntu:14.04.4
#镜像作者
MAINTAINER wangguangfu "wanggfu@gmail.com"

#添加源
ADD sources.list /etc/apt

#镜像构建时执行的命令
#更新软件包列表和安装编译环境
RUN apt-get update && apt-get -y install build-essential

#拷贝blink编译依赖包
ADD install-build-deps-android.sh /opt/install-build-deps-android.sh
ADD install-build-deps.sh /opt/install-build-deps.sh

#安装blink编译依赖包
RUN chmod 744 /opt/install-build-deps-android.sh /opt/install-build-deps.sh
RUN /bin/bash /opt/install-build-deps-android.sh

#声明运行时容器提供的端口号，需要docker run -p 端口号，才会启用
#SSH登录端口号
EXPOSE 22

#安装SSH服务
RUN apt-get install -y openssh-server net-tools

#设置环境变量，设置之后，后面的指令和运行时的应用都可以使用
#用户名为wangguangfu
ENV	USERNAME=wangguangfu

#RUN groupadd $USERNAME && useradd -r -g $USERNAME $USERNAME && mkdir /home/$USERNAME
RUN useradd --create-home --no-log-init --shell /bin/bash $USERNAME

RUN echo "$USERNAME:$USERNAME"|chpasswd

#添加sudo权限
RUN echo "$USERNAME ALL=(ALL) ALL" >> /etc/sudoers

#挂载匿名卷
#编译工具目录/opt 代码目录~/sunniwell
VOLUME ["/opt", "/home/$USERNAME/sunniwell"]

RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd

#启动sshd
CMD ["/usr/sbin/sshd", "-D"]

#切换工作目录
WORKDIR /home/$USERNAME
