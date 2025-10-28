
DRIVER_SRC = rs_driver.c

APP_SRC = rs_app.c

obj-m += $(DRIVER_SRC:.c=.o)

# KERNEL_SRC will be passed from Yocto build system
# KERNEL_SRC = /lib/modules/$(shell uname -r)/build

SRC := $(shell pwd)

all: rs_driver

rs_driver:
	$(MAKE) -C $(KERNEL_SRC) M=$(SRC)

modules_install:
	$(MAKE) -C $(KERNEL_SRC) M=$(SRC) modules_install

rs_app: $(APP_SRC) rs_driver_ioctl.h
	gcc -o rs_app $(APP_SRC)

clean:
	rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c
	rm -f Module.markers Module.symvers modules.order
	rm -rf .tmp_versions Modules.symvers
