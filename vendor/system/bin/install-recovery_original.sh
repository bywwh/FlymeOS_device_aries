#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 7311360 173b12af8064c9b1339891cac1096b2d85d58e1c 5042176 9432287fffcd4b7740214dbd9d6cc1613e498d0d
fi

if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:7311360:173b12af8064c9b1339891cac1096b2d85d58e1c; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:5042176:9432287fffcd4b7740214dbd9d6cc1613e498d0d EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery 173b12af8064c9b1339891cac1096b2d85d58e1c 7311360 9432287fffcd4b7740214dbd9d6cc1613e498d0d:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
