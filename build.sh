#!/bin/bash
FLYME_OUT_DIR=/home/bywwh/AndroidSource/FlymeOS/devices/aries/out
DEVICE_DIR=/home/bywwh/AndroidSource/FlymeOS/devices/aries
OTHER_DIR=/home/bywwh/AndroidSource/FlymeOS/devices/aries/other
cd ../..
. build/envsetup.sh
echo
echo ">>> in devices dir"
cd -
echo
flyme clean
flyme fullota

if [ -e $FLYME_OUT_DIR/flyme*.zip ];then
mv -vf $FLYME_OUT_DIR/flyme*.zip $FLYME_OUT_DIR/FlymeOS_aries-$USER-$(date +%Y%m%d)-5.1.1.zip
fi

echo
echo ">>> make merge partition patch"
echo
cp -rf $DEVICE_DIR/boot.img.out $DEVICE_DIR/boot.img.out.bak
cp -rf $DEVICE_DIR/framework-res $DEVICE_DIR/framework-res.bak
cp -rf $OTHER_DIR/storage_list.xml $DEVICE_DIR/framework-res/res/xml
cp -rf $OTHER_DIR/fstab.qcom $OTHER_DIR/init.target.rc $DEVICE_DIR/boot.img.out/RAMDISK
echo
echo ">>> make fullota again"
echo
cd $DEVICE_DIR
flyme fullota
rm -rf $DEVICE_DIR/boot.img.out $DEVICE_DIR/framework-res
mv -vf $DEVICE_DIR/boot.img.out.bak $DEVICE_DIR/boot.img.out
mv -vf $DEVICE_DIR/framework-res.bak $DEVICE_DIR/framework-res

if [ -e $FLYME_OUT_DIR/flyme*.zip ];then
mv -vf $FLYME_OUT_DIR/flyme*.zip $FLYME_OUT_DIR/FlymeOS_aries-$USER-$(date +%Y%m%d)-mixed-5.1.1.zip
fi
