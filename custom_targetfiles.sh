echo ">>> in $0"
OUT_DIR=/home/bywwh/AndroidSource/FlymeOS/devices/aries/out/merged_target_files

cd $OUT_DIR
echo ">>> delete $OUT_DIR/DATA"
rm -rf DATA/
echo ">>> delete some files"
rm -rf $OUT_DIR/SYSTEM/priv-app/Settings/Settings
echo ">>> create dir DATA/"
mkdir -vp DATA/
echo ">>> move some apps into data"
mkdir -vp $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/priv-app $OUT_DIR/DATA/system_app
