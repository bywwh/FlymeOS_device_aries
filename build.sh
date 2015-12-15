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
cp -v -rf $DEVICE_DIR/boot.img.out $DEVICE_DIR/boot.img.out.bak
cp -v -rf $DEVICE_DIR/framework-res $DEVICE_DIR/framework-res.bak
cp -v -rf $OTHER_DIR/storage_list.xml $DEVICE_DIR/framework-res/res/xml
cp -v -rf $OTHER_DIR/fstab.qcom $OTHER_DIR/init.target.rc $DEVICE_DIR/boot.img.out/RAMDISK
echo
echo ">>> make fullota again"
echo
mkdir -vp $DEVICE_DIR/tmp
mv -vf $FLYME_OUT_DIR/*.zip $DEVICE_DIR/tmp
cd $DEVICE_DIR
flyme clean
flyme fullota
rm -v -rf $DEVICE_DIR/boot.img.out $DEVICE_DIR/framework-res
mv -vf $DEVICE_DIR/boot.img.out.bak $DEVICE_DIR/boot.img.out
mv -vf $DEVICE_DIR/framework-res.bak $DEVICE_DIR/framework-res

if [ -e $FLYME_OUT_DIR/flyme*.zip ];then
mv -vf $FLYME_OUT_DIR/flyme*.zip $FLYME_OUT_DIR/FlymeOS_aries-$USER-$(date +%Y%m%d)-mixed-5.1.1.zip
fi

if [ -e $DEVICE_DIR/tmp/*.zip ];then
mv -vf $DEVICE_DIR/tmp/*.zip $FLYME_OUT_DIR
rm -v -rf $DEVICE_DIR/tmp
fi
