
DRIVER_SRC = rs_driver.c

APP_SRC = rs_app.c

obj-m += $(DRIVER_SRC:.c=.o)

# KERNEL_SRC will be passed from Yocto build system
# KERNEL_SRC = /lib/modules/$(shell uname -r)/build

all: rs_driver rs_app

rs_driver:
	$(MAKE) -C $(KERNEL_SRC) M=$(PWD) modules

rs_app: $(APP_SRC) rs_driver_ioctl.h
	gcc -o rs_app $(APP_SRC)

clean:
	$(MAKE) -C $(KERNEL_SRC) M=$(PWD) clean
	rm -f rs_app
