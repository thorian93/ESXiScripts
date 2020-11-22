#!/bin/sh

TODAY="$(date +%w)"
BACKUP_ROOT='/vmfs/volumes/datastore/folder'
GHETTO_CONFIG="$BACKUP_ROOT/ghettoVCB-master/ghettoVCB.conf"
LOGFILE="$BACKUP_ROOT/ghettoVCB-master/logs/$(date +%Y%m%d)_ghetto.log"
VM_LIST_DAY="$BACKUP_ROOT/ghettoVCB-master/ghetto_vm_list_day.txt"
VM_LIST_WEEK="$BACKUP_ROOT/ghettoVCB-master/ghetto_vm_list_week.txt"
DOW_WEEKLY='0'

# Debug Variables:
if [ "$1" == 'debug' ]
then
    echo "TODAY = $TODAY"
    echo "BACKUP_ROOT = $BACKUP_ROOT"
    echo "GHETTO_CONFIG = $GHETTO_CONFIG"
    echo "LOGFILE = $LOGFILE"
    echo "VM_LIST_DAY = $VM_LIST_DAY"
    echo "VM_LIST_WEEK = $VM_LIST_WEEK"
    echo "DOW_WEEKLY = $DOW_WEEKLY"
    exit 0
fi

# Run Daily except on Weekly run:
if [ "$TODAY" -ne $DOW_WEEKLY ]
then
    $BACKUP_ROOT/ghettoVCB-master/ghettoVCB.sh -f $VM_LIST_DAY -l $LOGFILE -g $GHETTO_CONFIG
fi

# Run Weekly:
if [ "$TODAY" -eq $DOW_WEEKLY ]
then
    $BACKUP_ROOT/ghettoVCB-master/ghettoVCB.sh -f $VM_LIST_WEEK -l $LOGFILE -g $GHETTO_CONFIG
fi