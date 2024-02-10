#!/bin/bash

toJournal(){
    echo $1 | systemd-cat  -t USBAutomountInstall -p info
}

toConsole(){
    echo $1 
}

install(){
    toJournal "Move mount_usb.sh to /usr/local/bin/"
    toConsole "Move mount_usb.sh to /usr/local/bin/"
    cp mount_usb.sh /usr/local/bin/mount_usb.sh
    toJournal "Move mount_usb@.service to /etc/systemd/system/"
    toConsole "Move mount_usb@.service to /etc/systemd/system/"
    cp mount_usb@.service /etc/systemd/system/mount_usb@.service
    toJournal "Move 99-mount_usb.rules to /etc/udev/rules.d/"
    toConsole "Move 99-mount_usb.rules to /etc/udev/rules.d/"
    cp 99-mount_usb.rules /etc/udev/rules.d/99-mount_usb.rules
}

reload(){
    toJournal "Reload rules"
    toConsole "Reload rules"
    udevadm control --reload-rules
    toJournal "Reload daemon"
    toConsole "Reload daemon"
    systemctl daemon-reload
}


install
reload