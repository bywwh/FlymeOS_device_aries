#!/bin/bash
cd ../..
echo
echo ">>> 初始化编译环境"
. build/envsetup.sh
echo
echo
echo ">>> 进入机型目录"
cd -
echo
echo
echo ">>> 清除缓存文件"
make clean
echo ">>> 编译刷机包"
make fullota

if [ -e ./out/flyme*.zip ]
   then
mkdir -p out/flyme
mv ./out/flyme*.zip ./out/flyme
cd ./out/flyme
unzip flyme*.zip
rm -rf flyme*.zip
patch -p1 < ../../other/updater-script.patch
cp -rf ../../other/supersu ./
mkdir -p data/system_app
mv system/app system/priv-app data/system_app
cp -rf ../../other/data ./

# make merge partition patch
mkdir -p flyme_merge_partition
cp -rf boot.img system/framework/framework-res.apk ./flyme_merge_partition
cd flyme_merge_partition
apktool if framework-res.apk
apktool d framework-res.apk
unpack_bootimg boot.img boot.img.out
patch -p1 < ../../../other/Merge_partition.patch
apktool b framework-res
pack_bootimg boot.img.out boot.img
mv framework-res/build/apk/res ./
zip -m framework-res.apk ./res/xml/storage_list.xml
cp -rf ../../../other/META-INF ./
mkdir -p system/framework
mv framework-res.apk system/framework
zip -r merge_partition.zip META-INF system boot.img
java -jar ../../../../../build/tools/signapk.jar ../../../../../build/security/platform.x509.pem ../../../../../build/security/platform.pk8 merge_partition.zip FlymeOS_aries_merge_partition_$(date +%Y%m%d).zip
mv FlymeOS*.zip ../../
cd ..
rm -rf flyme_merge_partition
# end

zip -r flyme.zip *
java -jar ../../../../build/tools/signapk.jar ../../../../build/security/platform.x509.pem ../../../../build/security/platform.pk8 flyme.zip FlymeOS_aries-$USER-$(date +%Y%m%d)-5.1.1.zip
mv FlymeOS*.zip ../
rm -rf ../flyme
echo
echo "刷机包编译完成！刷机包在out目录中"
cd ..
pwd
echo
fi
