# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# This file is the device-specific product definition file for
# crespo. It lists all the overlays, files, modules and properties
# that are specific to this hardware: i.e. those are device-specific
# drivers, configuration files, settings, etc...

# Note that crespo is not a fully open device. Some of the drivers
# aren't publicly available in all circumstances, which means that some
# of the hardware capabilities aren't present in builds where those
# drivers aren't available. Such cases are handled by having this file
# separated into two halves: this half here contains the parts that
# are available to everyone, while another half in the vendor/ hierarchy
# augments that set with the parts that are only relevant when all the
# associated drivers are available. Aspects that are irrelevant but
# harmless in no-driver builds should be kept here for simplicity and
# transparency. There are two variants of the half that deals with
# the unavailable drivers: one is directly checked into the unreleased
# vendor tree and is used by engineers who have access to it. The other
# is generated by setup-makefile.sh in the same directory as this files,
# and is used by people who have access to binary versions of the drivers
# but not to the original vendor tree. Be sure to update both.


# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.

# Inherit from those products. Most specific first.
$(call inherit-product, build/target/product/languages_full.mk)
$(call inherit-product, build/target/product/full_base.mk)

# Add device package overlay
DEVICE_PACKAGE_OVERLAYS := device/samsung/totoro/overlay

# Libs
PRODUCT_PACKAGES += \
	libstagefrighthw \
	overlay.totoro \
	lights.totoro

# update utilities
PRODUCT_PACKAGES += \
    setup_fs \
    SamsungServiceMode \
    libcopybit \
    gralloc.totoro \
    libhardware_legacy \
    bdaddr_read \
    toggleshutter \
    patchlcs \
    dexpreopt \
    dump_image \
    e2fsck \
    erase_image \
    flash_image

# Add LDPI assets, in addition to MDPI
  PRODUCT_LOCALES += ldpi mdpi

# Extra overlay for LDPI
  PRODUCT_PACKAGE_OVERLAYS += vendor/cyanogen/overlay/ldpi

  

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml


PRODUCT_PROPERTY_OVERRIDES += \
       wifi.interface=eth0 \
       wifi.supplicant_scan_interval=20 \
       ro.telephony.ril_class=samsung \
       ro.telephony.sends_barcount=1 \
       mobiledata.interfaces=pdp0,eth0,gprs,ppp0 \
       dalvik.vm.heapsize=64m \
       persist.service.usb.setting=0 \
       dev.sfbootcomplete=0 \
       persist.sys.vold.switchexternal=1

#kernel modules
PRODUCT_COPY_FILES += \
    device/samsung/totoro/prebuilt/fsr.ko:root/fsr.ko \
    device/samsung/totoro/prebuilt/fsr_stl.ko:root/fsr_stl.ko \
    device/samsung/totoro/prebuilt/rfs_fat.ko:root/rfs_fat.ko \
    device/samsung/totoro/prebuilt/rfs_glue.ko:root/rfs_glue.ko \
    device/samsung/totoro/prebuilt/j4fs.ko:root/j4fs.ko \
    device/samsung/totoro/prebuilt/sec_param.ko:root/sec_param.ko \
# Board-specific init
PRODUCT_COPY_FILES += \
    device/samsung/totoro/ueventd.gt-s5360.rc:root/ueventd.gt-s5360.rc \
    device/samsung/totoro/init.gt-s5360.rc:root/init.gt-s5360.rc

    

#audio
PRODUCT_COPY_FILES += \
vendor/samsung/totoro/proprietary/system/lib/liblvvefs.so:system/lib/liblvvefs.so \
vendor/samsung/totoro/proprietary/system/lib/lib_Samsung_Resampler.so:system/lib/lib_Samsung_Resampler.so \
vendor/samsung/totoro/proprietary/system/lib/libsamsungSoundbooster.so:system/lib/libsamsungSoundbooster.so \
vendor/samsung/totoro/proprietary/system/lib/lib_Samsung_Sound_Booster.so:system/lib/lib_Samsung_Sound_Booster.so \
vendor/samsung/totoro/proprietary/system/lib/libsamsungAcousticeq.so:system/lib/libsamsungAcousticeq.so \
vendor/samsung/totoro/proprietary/system/lib/lib_Samsung_Acoustic_Module_Llite.so:system/lib/lib_Samsung_Acoustic_Module_Llite.so \
vendor/samsung/totoro/proprietary/system/lib/libsoundalive.so:system/lib/libsoundalive.so \
vendor/samsung/totoro/proprietary/system/lib/lib_R2VS_ARM_GA_Library_for_EUROPA.so:system/lib/lib_R2VS_ARM_GA_Library_for_EUROPA.so \
vendor/samsung/totoro/proprietary/system/lib/libmedia.so:system/lib/libmedia.so \
vendor/samsung/totoro/proprietary/system/lib/libaudioflinger.so:system/lib/libaudioflinger.so \
vendor/samsung/totoro/proprietary/system/lib/liba2dp.so:system/lib/liba2dp.so \
#vendor/samsung/totoro/proprietary/system/lib/libaudio.so:system/lib/libaudio.so \
#vendor/samsung/totoro/proprietary/system/bin/mediaserver:system/bin/mediaserver \
#vendor/samsung/totoro/proprietary/system/lib/libsisodrm.so:system/lib/libsisodrm.so \
#vendor/samsung/totoro/proprietary/system/lib/libomadrm.so:system/lib/libomadrm.so \
#vendor/samsung/totoro/proprietary/system/lib/librs_jni.so:system/lib/librs_jni.so \
#vendor/samsung/totoro/proprietary/system/lib/libRS.so:system/lib/libRS.so \
#vendor/samsung/totoro/proprietary/system/lib/liblzo.so:system/lib/liblzo.so \

# apns config file
PRODUCT_COPY_FILES += \
        vendor/cyanogen/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

#mediaplayer
PRODUCT_COPY_FILES += \
vendor/samsung/totoro/proprietary/system/etc/media_profiles.xml:system/etc/media_profiles.xml \
vendor/samsung/totoro/proprietary/system/lib/libBRCM_omx_core.so:system/lib/libBRCM_omx_core.so \
vendor/samsung/totoro/proprietary/system/lib/libBRCM_omx_core_plugin.so:system/lib/libBRCM_omx_core_plugin.so \
vendor/samsung/totoro/proprietary/system/lib/invoke_mock_media_player.so:system/lib/invoke_mock_media_player.so \
vendor/samsung/totoro/proprietary/system/lib/libomx_aacdec_sharedlibrary.so:system/lib/libomx_aacdec_sharedlibrary.so \
vendor/samsung/totoro/proprietary/system/lib/libomx_amrdec_sharedlibrary.so:system/lib/libomx_amrdec_sharedlibrary.so \
vendor/samsung/totoro/proprietary/system/lib/libomx_avcdec_sharedlibrary.so:system/lib/libomx_avcdec_sharedlibrary.so \
vendor/samsung/totoro/proprietary/system/lib/libomx_m4vdec_sharedlibrary.so:system/lib/libomx_m4vdec_sharedlibrary.so \
vendor/samsung/totoro/proprietary/system/lib/libomx_mp3dec_sharedlibrary.so:system/lib/libomx_mp3dec_sharedlibrary.so \
vendor/samsung/totoro/proprietary/system/lib/libomx_sharedlibrary.so:system/lib/libomx_sharedlibrary.so \
#vendor/samsung/totoro/proprietary/system/lib/libopencore_author.so:system/lib/libopencore_author.so \
#vendor/samsung/totoro/proprietary/system/lib/libopencore_common.so:system/lib/libopencore_common.so \
#vendor/samsung/totoro/proprietary/system/lib/libopencore_mp4local.so:system/lib/libopencore_mp4local.so \
#vendor/samsung/totoro/proprietary/system/lib/libopencore_mp4localreg.so:system/lib/libopencore_mp4localreg.so \
#vendor/samsung/totoro/proprietary/system/lib/libopencore_net_support.so:system/lib/libopencore_net_support.so \
#vendor/samsung/totoro/proprietary/system/lib/libopencore_player.so:system/lib/libopencore_player.so \
#vendor/samsung/totoro/proprietary/system/lib/libopencore_rtsp.so:system/lib/libopencore_rtsp.so \
#vendor/samsung/totoro/proprietary/system/lib/libopencore_rtspreg.so:system/lib/libopencore_rtspreg.so \
#vendor/samsung/totoro/proprietary/system/lib/libOpenSLES.so:system/lib/llibOpenSLES.so \

#usb
PRODUCT_COPY_FILES += \
vendor/samsung/totoro/proprietary/system/etc/vold.fstab:system/etc/vold.fstab \
#vendor/samsung/totoro/proprietary/system/bin/vold:system/bin/vold \
#vendor/samsung/totoro/proprietary/system/bin/usb_portd:system/bin/usb_portd \
#vendor/samsung/totoro/proprietary/system/etc/usb_portd.conf:system/etc/usb_portd.conf \
#vendor/samsung/totoro/proprietary/system/etc/usb_tether.sh:system/etc/usb_tether.sh \
#vendor/samsung/totoro/proprietary/system/etc/usbconfig.sh:system/etc/usbconfig.sh \
#vendor/samsung/totoro/proprietary/system/etc/dbus.conf:system/etc/dbus.conf \

#vendor/samsung/totoro/proprietary/system/etc/usbmode.txt:system/etc/usbmode.txt \
#phone
#PRODUCT_COPY_FILES += \

#camera
PRODUCT_COPY_FILES += \
vendor/samsung/totoro/proprietary/system/lib/libarccamera.so:system/lib/libarccamera.so \
vendor/samsung/totoro/proprietary/system/lib/libbrcmjpeg.so:system/lib/libbrcmjpeg.so \
vendor/samsung/totoro/proprietary/system/lib/libcamera.so:system/lib/libcamera.so \
vendor/samsung/totoro/proprietary/system/lib/libCaMotion.so:system/lib/libCaMotion.so \
vendor/samsung/totoro/proprietary/system/lib/libPanoraMax1.so:system/lib/libPanoraMax1.so \
vendor/samsung/totoro/proprietary/system/lib/libseccamera.so:system/lib/libseccamera.so \
vendor/samsung/totoro/proprietary/system/lib/libseccameraadaptor.so:system/lib/libseccameraadaptor.so \
vendor/samsung/totoro/proprietary/system/lib/libcamera_client.so:system/lib/libcamera_client.so \
vendor/samsung/totoro/proprietary/system/lib/libcameraservice.so:system/lib/libcameraservice.so \
vendor/samsung/totoro/proprietary/system/lib/libcaps.so:system/lib/libcaps.so \

#sensores

PRODUCT_COPY_FILES += \
vendor/samsung/totoro/proprietary/system/lib/libdhwr.so:system/lib/libdhwr.so 
vendor/samsung/totoro/proprietary/system/lib/hw/acoustics.default.so:system/lib/hw/acoustics.default.so \
vendor/samsung/totoro/proprietary/system/lib/hw/alsa.default.so:system/lib/hw/alsa.default.so \
vendor/samsung/totoro/proprietary/system/lib/hw/alsa.default.so:system/lib/hw/alsa.default.so \
vendor/samsung/totoro/proprietary/system/lib/hw/gps.bcm21553.so:system/lib/hw/gps.bcm21553.so \
vendor/samsung/totoro/proprietary/system/lib/hw/gps.goldfish.so:system/lib/hw/gps.goldfish.so \
vendor/samsung/totoro/proprietary/system/lib/hw/lights.bcm21553.so:system/lib/hw/lights.bcm21553.so \
vendor/samsung/totoro/proprietary/system/lib/hw/sensors.default.so:system/lib/hw/sensors.default.so \
vendor/samsung/totoro/proprietary/system/lib/hw/sensors.goldfish.so:system/lib/hw/sensors.goldfish.so \
vendor/samsung/totoro/proprietary/system/lib/libaccsensorcal.so:system/lib/libaccsensorcal.so \
vendor/samsung/totoro/proprietary/system/lib/libaccsensorcaltest.so:system/lib/libaccsensorcaltest.so \
vendor/samsung/totoro/proprietary/system/lib/libaccelcal.so:system/lib/libaccelcal.so \


#keychars
PRODUCT_COPY_FILES += \
vendor/samsung/totoro/proprietary/system/usr/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
vendor/samsung/totoro/proprietary/system/usr/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin \
vendor/samsung/totoro/proprietary/system/usr/keychars/sec_key.kcm.bin:system/usr/keychars/sec_key.kcm.bin \
vendor/samsung/totoro/proprietary/system/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
vendor/samsung/totoro/proprietary/system/usr/keylayout/bcm_headset.kl:system/usr/keylayout/bcm_headset.kl \
vendor/samsung/totoro/proprietary/system/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
vendor/samsung/totoro/proprietary/system/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
vendor/samsung/totoro/proprietary/system/usr/keylayout/sec_key.kl:system/usr/keylayout/sec_key.kl \
vendor/samsung/totoro/proprietary/system/usr/keylayout/sec_keypad.kl:system/usr/keylayout/sec_keypad.kl \

#bluetooth
PRODUCT_COPY_FILES += \
#vendor/samsung/totoro/proprietary/system/lib/libbluedroid.so:system/lib/libbluedroid.so \
#vendor/samsung/totoro/proprietary/system/lib/libbluetooth.so:system/lib/libbluetooth.so \
#vendor/samsung/totoro/proprietary/system/lib/libbluetoothd.so:system/lib/libbluetoothd.so \
#vendor/samsung/totoro/proprietary/system/usr/bluetooth/print/icon_calendar.jpg:system/usr/bluetooth/print/icon_calendar.jpg \
#vendor/samsung/totoro/proprietary/system/usr/bluetooth/print/icon_contact.jpg:system/usr/bluetooth/print/icon_contact.jpg \
#vendor/samsung/totoro/proprietary/system/usr/bluetooth/print/icon_email.jpg:system/usr/bluetooth/print/icon_email.jpg \
#vendor/samsung/totoro/proprietary/system/usr/bluetooth/print/icon_man.jpg:system/usr/bluetooth/print/icon_man.jpg \
#vendor/samsung/totoro/proprietary/system/usr/bluetooth/print/icon_mms.jpg:system/usr/bluetooth/print/icon_mms.jpg \
#vendor/samsung/totoro/proprietary/system/usr/bluetooth/print/icon_sms.jpg:system/usr/bluetooth/print/icon_sms.jpg \
#vendor/samsung/totoro/proprietary/system/usr/bluetooth/print/logo.jpg:system/usr/bluetooth/print/logo.jpg \
#vendor/samsung/totoro/proprietary/system/usr/bluetooth/print/title.jpg:system/usr/bluetooth/print/title.jpg \
#vendor/samsung/totoro/proprietary/system/etc/bluetooth/audio.conf:system/etc/bluetooth/audio.conf \
#vendor/samsung/totoro/proprietary/system/etc/bluetooth/auto_pairing.conf:system/etc/bluetooth/auto_pairing.conf \
#vendor/samsung/totoro/proprietary/system/etc/bluetooth/blacklist.conf:system/etc/bluetooth/blacklist.conf \
#vendor/samsung/totoro/proprietary/system/etc/bluetooth/input.conf:system/etc/bluetooth/input.conf \
#vendor/samsung/totoro/proprietary/system/etc/bluetooth/main.conf:system/etc/bluetooth/main.conf 

#gps
PRODUCT_COPY_FILES += \
vendor/samsung/totoro/proprietary/system/lib/libsoc.so:system/lib/libsoc.so \
vendor/samsung/totoro/proprietary/system/etc/gps/glconfig.xml:system/etc/gps/glconfig.xml \
vendor/samsung/totoro/proprietary/system/etc/gps/glconfig2075.xml:system/etc/gps/glconfig2075.xml \
vendor/samsung/totoro/proprietary/system/etc/gps/glconfig4751.xml:system/etc/gps/glconfig4751.xml \
vendor/samsung/totoro/proprietary/system/bin/glgps:system/bin/glgps \
vendor/samsung/totoro/proprietary/system/bin/gps.cer:system/bin/gps.cer \
vendor/samsung/totoro/proprietary/system/etc/gps.conf:system/etc/gps.conf \

#Wifi
PRODUCT_COPY_FILES += \
vendor/samsung/totoro/proprietary/system/etc/wifi/bcm4330_aps.bin:system/etc/wifi/bcm4330_aps.bin \
vendor/samsung/totoro/proprietary/system/etc/wifi/bcm4330_sta.bin:system/etc/wifi/bcm4330_sta.bin \
vendor/samsung/totoro/proprietary/system/etc/wifi/RC_248_WPA.bin:system/etc/wifi/RC_248_WPA.bin \
vendor/samsung/totoro/proprietary/system/etc/wifi/bcm4330_mfg.bin:system/etc/wifi/bcm4330_mfg.bin \
vendor/samsung/totoro/proprietary/system/etc/wifi/nvram_mfg.txt:system/etc/wifi/nvram_mfg.txt \
vendor/samsung/totoro/proprietary/system/etc/wifi/nvram.txt:system/etc/wifi/nvram.txt \
vendor/samsung/totoro/proprietary/system/etc/wifi/wifi.conf:system/etc/wifi/wifi.conf \
#vendor/samsung/totoro/proprietary/system/etc/wifi/wpa_supplicant.conf:system/etc/wifi/#wpa_supplicant.conf \


#rild
PRODUCT_COPY_FILES += \
vendor/samsung/totoro/proprietary/system/bin/rild:system/bin/rild \
vendor/samsung/totoro/proprietary/system/lib/libbrcm_ril.so:system/lib/libbrcm_ril.so \
vendor/samsung/totoro/proprietary/system/lib/liburilclient.so:system/lib/liburilclient.so \
vendor/samsung/totoro/proprietary/system/lib/libbrcm_ril.so:system/lib/libreference-ril.so \

#outros
PRODUCT_COPY_FILES += \
vendor/samsung/totoro/proprietary/system/bin/BCM4330B1_002.001.003.0485.0506.hcd:system/bin/BCM4330B1_002.001.003.0485.0506.hcd \
#vendor/samsung/totoro/proprietary/system/lib/libandroidterm2.so:system/lib/libandroidterm2.so \
#vendor/samsung/totoro/proprietary/system/lib/libterm.so:system/lib/libterm.so \

#Drivers
PRODUCT_COPY_FILES += \
vendor/samsung/totoro/proprietary/system/lib/modules/bcm_headsetsw.ko:system/lib/modules/bcm_headsetsw.ko \
vendor/samsung/totoro/proprietary/system/lib/modules/brcm_switch.ko:system/lib/modules/brcm_switch.ko \
vendor/samsung/totoro/proprietary/system/lib/modules/dhd.ko:system/lib/modules/bcm4330.ko \
vendor/samsung/totoro/proprietary/system/lib/modules/gememalloc.ko:system/lib/modules/gememalloc.ko \
vendor/samsung/totoro/proprietary/system/lib/modules/h6270enc.ko:system/lib/modules/h6270enc.ko \
vendor/samsung/totoro/proprietary/system/lib/modules/hx170dec.ko:system/lib/modules/hx170dec.ko 

# RIL properties
PRODUCT_PROPERTY_OVERRIDES += \
rild.libargs=-d/dev/smd0 \
rild.libpath=/system/lib/libbrcm_ril.so \
ro.telephony.ril_class=samsung \
ro.telephony.sends_barcount=1
#




# Verizon cdma stuff
PRODUCT_PROPERTY_OVERRIDES += \


# Verizon cdma stuff
PRODUCT_PROPERTY_OVERRIDES += \
       ro.telephony.default_network=4 \
       ro.ril.def.agps.mode=2 \
       ro.ril.samsung_cdma=true \
       ro.cdma.home.operator.numeric=310004 \
       ro.cdma.home.operator.alpha=Verizon \
       ro.cdma.homesystem=64,65,76,77,78,79,80,81,82,83 \
       ro.cdma.data_retry_config=default_randomization=2000,0,0,120000,180000,540000,960000 \
       ro.config.vc_call_vol_steps=15 \
       ro.cdma.otaspnumschema=SELC,3,00,07,80,87,88,99 \
       ro.telephony.call_ring.multiple=false \
       ro.telephony.call_ring.delay=3000 \
       ro.telephony.call_ring.absent=true \
       net.cdma.pppd.authtype=require-chap \
       net.cdma.pppd.user=user[SPACE]VerizonWireless \
       net.cdma.datalinkinterface=/dev/ttyCDMA0 \
       net.cdma.ppp.interface=ppp0 \
       net.connectivity.type=CDMA1 \
       net.interfaces.defaultroute=cdma \
       ro.telephony.ril_class=samsung \
       mobiledata.interfaces=eth0,ppp0 \
       ro.sf.hwrotation=90

# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.


# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
        ro.com.google.locationfeatures=1 \
        ro.com.google.networklocation=1

# Extended JNI checks
# The extended JNI checks will cause the system to run more slowly, but they can spot a variety of nasty bugs 
# before they have a chance to cause problems.
# Default=true for development builds, set by android buildsystem.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0 \
    dalvik.vm.checkjni=false

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# other kernel modules not in ramdisk
ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/samsung/totoro/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
$(call inherit-product-if-exists, vendor/samsung/totoro/totoro-vendor.mk)
