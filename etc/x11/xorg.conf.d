##https://bbs.archlinux.org/viewtopic.php?pid=1595276#p1595276


Section "Device"
   Identifier  "Intel Graphics"
   Driver      "intel"
   #Option      "AccelMethod"  "sna"
   Option      "TearFree"    "true" 
   Option      "DRI"    "3" 
EndSection
