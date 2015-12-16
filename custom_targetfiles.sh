echo ">>> in $0"
OUT_DIR=/home/bywwh/AndroidSource/FlymeOS/devices/aries/out/merged_target_files

cd $OUT_DIR
echo
echo ">>> delete $OUT_DIR/DATA"
echo
rm -v -rf DATA/
echo
echo ">>> delete $OUT_DIR/SYSTEM/priv-app/Settings/Settings"
echo
rm -v -rf $OUT_DIR/SYSTEM/priv-app/Settings/Settings
echo
echo ">>> create dir DATA/"
echo
mkdir -vp DATA/
echo
echo ">>> move some apps into data"
echo
mkdir -vp $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/priv-app $OUT_DIR/DATA/system_app
