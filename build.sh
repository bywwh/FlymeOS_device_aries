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
flyme clean
echo ">>> 编译刷机包"
flyme fullota

if [ -e ./out/flyme*.zip ]
   then
mkdir -p out/flyme
mv ./out/flyme*.zip ./out/flyme
cd ./out/flyme
unzip flyme*.zip
rm -rf flyme*.zip
rm -rf system/priv-app/Settings/Settings
patch -p1 < ../../other/updater-script.patch
cp -rf ../../other/supersu ./
mkdir -p data/system_app
mv system/app system/priv-app data/system_app
zip -r flyme.zip *
java -jar ../../../../build/tools/signapk.jar ../../../../build/security/platform.x509.pem ../../../../build/security/platform.pk8 flyme.zip FlymeOS_aries-$USER-$(date +%Y%m%d)-5.1.1.zip
mv FlymeOS*.zip ../

# make merge partition patch
mv system/framework/framework-res.apk ./
apktool if framework-res.apk
apktool d framework-res.apk
unpack_bootimg boot.img boot.img.out
patch -p1 < ../../other/Merge_partition.patch
apktool b framework-res
pack_bootimg boot.img.out boot.img
mv framework-res/build/apk/res ./
zip -m framework-res.apk ./res/xml/storage_list.xml
mv framework-res.apk system/framework
rm -rf framework-res res flyme.zip boot.img.out
zip -r merge_partition.zip *
java -jar ../../../../build/tools/signapk.jar ../../../../build/security/platform.x509.pem ../../../../build/security/platform.pk8 merge_partition.zip FlymeOS_aries-$USER-$(date +%Y%m%d)-mixed-5.1.1.zip
mv FlymeOS*.zip ../
# end

rm -rf ../flyme
echo
echo "刷机包编译完成！刷机包在out目录中"
cd ..
pwd
echo
fi
