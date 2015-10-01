#devices/aries

小米手机2/2S (aries) FlymeOS 基于CM12.1。

1.下载代码
===
使用下面的命令下载Flyme代码：

    $ mkdir FlymeOS
    $ cd FlymeOS
    $ repo init -u https://github.com/FlymeOS/manifest.git -b lollipop-5.0
    $ repo sync -c -j4

2.下载base_cm
===
下载完Flyme代码后，还要下载base_cm的lollipop-5.1分支的代码：

    $ cd devices
    $ git clone https://github.com/FlymeOS/devices-base_cm.git -b lollipop-5.1
    $ mv ./devices-base_cm ./base_cm

3.编译刷机包
===
还是在devices目录，使用下面的命令下载代码：

    $ git clone https://github.com/bywwh/FlymeOS_device_aries.git -b lollipop-5.1
    $ mv ./FlymeOS_device_aries ./aries
    $ cd aries && ./build.sh
