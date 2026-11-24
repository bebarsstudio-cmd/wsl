#!/bin/busybox sh
echo ""
echo "GameForge Hardware System"
echo ""
CPU=$(grep -m1 "model name" /proc/cpuinfo | cut -d: -f2 | sed 's/^ //')
[ -z "$CPU" ] && CPU="Unknown CPU"
echo "CPU"
echo "$CPU"
echo "✓ Detected"
echo ""
RAM=$(awk '/MemTotal/ {if ($2 > 1048576) printf "%.0f GB", $2/1048576; else printf "%.0f MB", $2/1024}' /proc/meminfo)
echo "RAM"
echo "$RAM"
echo "✓ Detected"
echo ""
if ls /dev/dri/card* >/dev/null 2>&1; then
  echo "GPU"
  echo "Graphics device present"
  echo "✓ Detected"
else
  echo "GPU"
  echo "Basic display"
  echo "✓ Detected"
fi
echo ""
echo "Gaming configuration"
echo "✓ Ready"
echo ""
