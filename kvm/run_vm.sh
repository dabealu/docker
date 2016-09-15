#!/bin/bash

# create vm qcow image if it doesnt exist
cd /virt_machines
exist=0
for image in $(ls *.qcow)
  do 
    if [[ ${image} == ${VM_NAME}.qcow ]]
      then exist=$((${exist}+1))
    fi     
done

if [[ ${exist} -eq 0 ]]
  then
    echo "VM image does not exist, creating $(pwd)/${VM_NAME}.qcow (${VM_HDSIZE} GB)"
    qemu-img create -f qcow2 ${VM_NAME}.qcow ${VM_HDSIZE}G
fi


# run vm with image created (enable cdrom if file exists)
if [[ -e ${VM_CDROM} ]]
  then
    echo "Starting ${VM_NAME}, MAC: $(qemu-mac-hasher.py ${VM_NAME}), spice port: ${SPICE_PORT} password: ${SPICE_PASSWD}"
    kvm -m ${VM_MEMORY} -cpu host -smp cores=${VM_CORES} -name ${VM_NAME} \
      -net nic,model=virtio,macaddr=$(qemu-mac-hasher.py "${VM_NAME}") \
      -net tap,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown,vhost=on \
      -drive file=${VM_NAME}.qcow,if=virtio \
      -vga qxl -spice port=${SPICE_PORT},addr=0.0.0.0,password=${SPICE_PASSWD} \
      -boot menu=on,splash-time=10000 \
      -cdrom ${VM_CDROM}
  else
     echo "Starting ${VM_NAME}, MAC: $(qemu-mac-hasher.py ${VM_NAME}), spice port: ${SPICE_PORT} password: ${SPICE_PASSWD}"
     kvm -m ${VM_MEMORY} -cpu host -smp cores=${VM_CORES} -name ${VM_NAME} \
       -net nic,model=virtio,macaddr=$(qemu-mac-hasher.py "${VM_NAME}") \
       -net tap,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown,vhost=on \
       -drive file=${VM_NAME}.qcow,if=virtio \
       -vga qxl -spice port=${SPICE_PORT},addr=0.0.0.0,password=${SPICE_PASSWD} \
       -boot menu=on,splash-time=10000
fi
