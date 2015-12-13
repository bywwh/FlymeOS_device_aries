#devices/aries

小米手机2/2S (aries) FlymeOS 基于秋叶随风ivan的AOSP（Android 5.1.1）。

1.下载代码
===
使用下面的命令下载Flyme代码：

    $ mkdir FlymeOS
    $ cd FlymeOS
    $ repo init -u https://github.com/FlymeOS/manifest.git
    $ repo sync -c -j4

2.切换base-lollipop-5.1
===
下载完Flyme代码后，还要切换base的lollipop-5.1分支的代码：

    $ cd devices/base
    $ git checkout lollipop-5.1

3.编译刷机包
===
还是在devices目录，使用下面的命令下载代码：

    $ git clone https://github.com/bywwh/FlymeOS_device_aries.git -b aosp-5.1
    $ mv ./FlymeOS_device_aries ./aries
    $ cd aries && ./build.sh
