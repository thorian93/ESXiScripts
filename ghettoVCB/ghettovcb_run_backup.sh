#!/bin/sh

GHETTO_CONFIG="/vmfs/volumes/datastore/folder/ghettoVCB-master/ghettoVCB.conf"
VM_LIST="/vmfs/volumes/datastore/folder/ghettoVCB-master/ghetto_vm_list.txt"
LOGFILE="/vmfs/volumes/datastore/folder/ghettoVCB-master/logs/$(date +%Y%m%d)_ghetto.log"

/vmfs/volumes/datastore/folder/ghettoVCB-master/ghettoVCB.sh -f $VM_LIST -l $LOGFILE -g $GHETTO_CONFIG