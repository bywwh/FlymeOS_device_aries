#!/bin/bash
cd ../..
echo
echo ">>> 初始化编译环境"
. build/envsetup.sh
echo
echo
echo ">>> 进入机型目录"
cd devices/aries
pwd
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
cp -rf ../../other/updater-script.patch ./
patch -p1 < updater-script.patch
rm -rf updater-script.patch
cp -rf ../../other/supersu ./
mkdir -p data/system_app
mv system/app system/priv-app data/system_app
zip -r flyme.zip *
java -jar ../../../../build/tools/signapk.jar ../../../../build/security/platform.x509.pem ../../../../build/security/platform.pk8 flyme.zip flyme_aries_bywwh_$(date +%Y%m%d).zip
mv flyme*.zip ../
rm -rf ../flyme
rm -rf ../flyme.zip
echo
echo "刷机包编译完成！刷机包在out目录中"
cd ..
pwd
echo
fi
