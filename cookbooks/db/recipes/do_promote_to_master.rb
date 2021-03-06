#
# Cookbook Name:: db
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rs_utils_marker :begin

# == Verify initalized database
# Check the node state to verify that we have correctly initialized this server.
#
db_state_assert :slave

# == Open port for slave replication by old-master
#
rule_port = node[:sys_firewall][:rule][:port].to_i
sys_firewall rule_port do
  port rule_port
  enable true
  ip_addr node[:db][:current_master_ip]
  action :update
end

# == Promote to master
# Do promote, but do not change master tags or node state yet.
#
include_recipe "db::setup_replication_privileges"

db node[:db][:data_dir] do
  action :promote
end

# == Schedule backups on slave
# This should be done before calling db::do_lookup_master 
# changes current_master from old to new. 
# 
remote_recipe "enable slave backups on oldmaster" do
  recipe "db::do_primary_backup_schedule_enable"
  recipients_tags "rs_dbrepl:master_instance_uuid=#{node[:db][:current_master_uuid]}"
end

# == Demote old master
#
remote_recipe "demote master" do
  recipe "db::handle_demote_master"
  attributes :remote_recipe => {
                :new_master_ip => node[:cloud][:private_ips][0],
                :new_master_uuid => node[:rightscale][:instance_uuid]
              }
  recipients_tags "rs_dbrepl:master_instance_uuid=#{node[:db][:current_master_uuid]}"
end

# == Tag as master
# Changes master status tags and node state
#
db_register_master

# == force a backup
#
db_do_backup "do force backup" do
  force true
end

# == Schedule master backups
#
include_recipe "db::do_primary_backup_schedule_enable"

rs_utils_marker :end
