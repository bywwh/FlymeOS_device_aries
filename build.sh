#!/bin/bash
echo ">>> in $0"
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

cd $OTHER_DIR
echo ">>> make merge partition patch"
mv -vf $OTHER_DIR/storage_list.xml $FLYME_OUT_DIR/obj/system/res/frw_res_decode/vendor/framework-res/res/xml
mv -vf $OTHER_DIR/fstab.qcom $OTHER_DIR/init.target.rc $FLYME_OUT_DIR/obj/BOOT/RAMDISK
echo ">>> make fullota again"
cd $DEVICE_DIR
flyme fullota

if [ -e $FLYME_OUT_DIR/flyme*.zip ];then
mv -vf $FLYME_OUT_DIR/flyme*.zip $FLYME_OUT_DIR/FlymeOS_aries-$USER-$(date +%Y%m%d)-mixed-5.1.1.zip
fi
