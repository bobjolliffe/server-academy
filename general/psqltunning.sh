#!/bin/bash
#Postgres RAM Calculator
#Author	: Renier Rousseau ;Potlaki Moloi
#Date 	: 29 August 2017

# Updated : 28 September 2017
# Author  : Renier Rousseau
#

#TODO - Error checking - user - writing ability
#Creating backup
cp /etc/postgresql/9.5/main/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf.bak
post_conf=/etc/postgresql/9.5/main/postgresql.conf

#Creating hisp.conf and adding it too the postgresql.conf
hispconf =/etc/postgresql/9.5/main/hisp.conf
touch $hispconf
echo 'include $hispconf' >> $post_conf

#System Variables
eth1Add=$(grep -E 'address 10.0.*' /etc/network/interfaces | awk '{print $2}')

#User Definened Variables
listing_address=$(echo "localhost, $eth1Add")
port=$(echo '3447')
max_conn=$(echo '900')
wal_buf=$(echo '-1')
wal_writer_delay=$(echo '10000')
check_point_target=$(echo '0.8')
sync_commit=$(echo 'off')


#Calculating System Varribles
free -m | grep Mem | awk '{ print $2}' > /tmp/.sys_ram.tmp
sys_ram=$(head -n 1 '/tmp/.sys_ram.tmp')
echo "The System has $sys_ram MB of RAM"

#Calculations for : 
sys_ram_avible=$(expr $sys_ram - 512)
echo "RAM Availbe to the Postgres : $sys_ram_avible MB"
#Shared Buffers
shared_buffers=$(echo $sys_ram_avible | awk '{printf "%.0f\n", $1*0.4}')
echo "Shared Buffer = $shared_buffers"
#Work Memory
work_mem=$(expr $sys_ram / 1024)
echo "Work Memory = $work_mem"
#Maintenance Work Memory
main_work_mem=$(expr $sys_ram / 32)
echo "Maintenance Work Memory = $main_work_mem"
#Effective Cache Size
effective_cahe=$(echo $sys_ram_avible'MB')
echo "Effective Cache Size = $effective_cahe"

#Effecting changes for : 
# echo "" >> $hispconf

#Listening Address
echo "listen_addresses = '$listing_address'" >> $hispconf
#Port
echo "port = $por" >> $hispconf
#Max Connections
echo "max_connections = $max_conn" >> $hispconf
#Shared Buffer
echo "shared_buffers = $shared_buffers" >> $hispconf
#Work Mem
echo "work_mem = $work_mem" >> $hispconf
#Maintenance Work Mem
echo "maintenance_work_mem = $main_work_mem" >> $hispconf
#Effective Cache Size
echo "effective_cache_size = $effective_cahe" >> $hispconf
#Synchronous Commit
echo "synchronous_commit = $sync_commit" >> $hispconf
#WAL Buffers
echo "wal_buffers = $wal_buf" >> $hispconf
#WAL Writer Delay
echo "wal_writer_delay = $wal_writer_delay" >> $hispconf
#Checkpoint Completion Target
echo "checkpoint_completion_target = $check_point_target" >> $hispconf


# #Listening Address
# sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '$listing_address'/g" $post_conf
# #Port
# sed -i "s/port = 5432/port = $port/g" $post_conf
# #Max Connections
# sed -i "s/max_connections = 100/max_connections = $max_conn/g" $post_conf
# #Shared Buffer
# sed -i "s/shared_buffers = 128/shared_buffers = $shared_buffers/g" $post_conf
# #Work Mem
# sed -i "s/#work_mem = 4/work_mem = $work_mem/g" $post_conf
# #Maintenance Work Mem
# sed -i "s/#maintenance_work_mem = 64/maintenance_work_mem = $main_work_mem/g" $post_conf
# #Effective Cache Size
# sed -i "s/#effective_cache_size = 4GB/effective_cache_size = $effective_cahe/g" $post_conf
# #Synchronous Commit
# sed -i "s/#synchronous_commit = on/synchronous_commit = $sync_commit/g" $post_conf
# #WAL Buffers
# sed -i "s/#wal_buffers = -1/wal_buffers = $wal_buf/g" $post_conf
# #WAL Writer Delay
# sed -i "s/#wal_writer_delay = 200/wal_writer_delay = $wal_writer_delay/g" $post_conf
# #Checkpoint Completion Target
# sed -i "s/#checkpoint_completion_target = 0.5/checkpoint_completion_target = $check_point_target/g" $post_conf
