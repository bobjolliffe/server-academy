#!/bin/bash
#Postgres RAM Calculator
#Author	: Renier Rousseau ;Potlaki Moloi ;Bob Jolliffe
#Created Date 	: 29 August 2017

os_reserved=512
total_allocatedK=$(head -n 1 /proc/meminfo |awk '{print $2}')
sys_ram=$(expr $total_allocatedK / 1024)
max_connections=-1

while getopts ":m:n:o:" opt;
do
  case $opt in
    m)
      sys_ram=$OPTARG;
      ;;    
    n)
      max_connections=$OPTARG;
      ;;
    o)
      os_reserved=$OPTARG;
      ;;
    \?)
      echo "Invalid option -$opt" >&2
      exit 1;
      ;;
    :)
      echo "Option -$opt requires an argument." >&2
      exit 1
  esac
done

shift $(( $OPTIND-1 ))

if [ $max_connections -eq -1 ]; then
  echo "usage: bla bla"
  exit -1
fi

#System Variables
eth1Add=$(grep -E 'address 10.0.*' /etc/network/interfaces | awk '{print $2}')

#User Definened Variables
listing_address=$(echo "localhost, $eth1Add")
port=$(echo '3447')
wal_buf=$(echo '-1')
wal_writer_delay=$(echo '10000')
check_point_target=$(echo '0.8')
sync_commit=$(echo 'off')

#Calculations for : 
sys_ram_available=$(expr $sys_ram - $os_reserved)
#Shared Buffers
shared_buffers=$(echo $sys_ram_available | awk '{printf "%.0f\n", $1*0.4}')
#Work Memory
work_mem=$(expr $sys_ram / 1024)
#Maintenance Work Memory
main_work_mem=$(expr $sys_ram / 32)
#Effective Cache Size
effective_cahe=$(echo $sys_ram_available'MB')

#Effecting changes for : 
# echo "" >> $hispconf

#Listening Address
echo "listen_addresses = '$listing_address'" 
#Port
echo "port = $port"
#Max Connections
echo "max_connections = $max_connections" 
#Shared Buffer
echo "shared_buffers = $shared_buffers"
#Work Mem
echo "work_mem = $work_mem"
#Maintenance Work Mem
echo "maintenance_work_mem = $main_work_mem"
#Effective Cache Size
echo "effective_cache_size = $effective_cahe"
#Synchronous Commit
echo "synchronous_commit = $sync_commit"
#WAL Buffers
echo "wal_buffers = $wal_buf"
#WAL Writer Delay
echo "wal_writer_delay = $wal_writer_delay"
#Checkpoint Completion Target
echo "checkpoint_completion_target = $check_point_target"


