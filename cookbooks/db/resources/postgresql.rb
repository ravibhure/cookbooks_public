#
# Cookbook Name:: db
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# Add actions to @action_list array.
# Used to allow comments between entries.

# == Enable slave Replication
# Configures and start a slave replicating from master
add_action :enable_slave

# = Database Attributes
#
# Below are the attributes defined by the db resource interface.
#

# == General options
attribute :user, :kind_of => String, :default => "root"
attribute :password, :kind_of => String, :default => ""
attribute :data_dir, :kind_of => String, :default => "/mnt/storage"

# == Backup/Restore options
attribute :lineage, :kind_of => String
attribute :force, :kind_of => String, :default => "false"
attribute :timestamp_override, :kind_of => String, :default => nil
attribute :from_master, :kind_of => String, :default => nil

# == Privilege options
attribute :privilege, :equal_to => [ "administrator", "user" ], :default => "administrator"
attribute :privilege_username, :kind_of => String
attribute :privilege_password, :kind_of => String
attribute :privilege_database, :kind_of => String, :default => "*.*" # All databases

# == Firewall options
attribute :enable, :equal_to => [ true, false ], :default => true
attribute :ip_addr, :kind_of => String
attribute :machine_tag, :kind_of => String, :regex => /^([^:]+):(.+)=.+/

# == Import/Export options
attribute :dumpfile, :kind_of => String
attribute :db_name, :kind_of => String

#attribute :name, :kind_of => String, :name_attribute => true
#attribute :type, :kind_of => String
