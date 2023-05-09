LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# create config.h and modify it
CONFIG_H := config.h
$(shell cd $(LOCAL_PATH)/src; \
	test ! -f $(CONFIG_H) && \
	./configure --host=arm-linux > /dev/null 2>&1; \
	cp $(CONFIG_H){,.bak}; \
	sed "/HAVE_NET_ETHERNET_H/s#\(.*\)#//\1#" $(CONFIG_H).bak > $(CONFIG_H); \
	rm -f $(CONFIG_H).bak \
)

LOCAL_SRC_FILES := \
	pppoe.c \
	if.c \
	debug.c \
	common.c \
	ppp.c \
	discovery.c
LOCAL_SRC_FILES := $(addprefix src/, $(LOCAL_SRC_FILES)) 

LOCAL_CFLAGS := \
	-DPPPD_PATH=\"/system/bin/pppd\" \
	-DVERSION=\"3.10\"

LOCAL_MODULE := pppoe
LOCAL_MODULE_TAGS := optional
include $(BUILD_EXECUTABLE)
