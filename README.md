#搭建blink编译环境 避免编译环境依赖造成的错误

创建容器方法

1、修改start.sh中映射端口号.改成分配给自己的端口号如11203，则改11202:22位11203:22

2、不使用VOLUME，直接在容器中下载代码

3、修改start.sh容器名，如sunke_blinkbuild则修改wanggfu/blinkbulid为sunke_blinkbuild
