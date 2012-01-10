maintainer       "YOUR_COMPANY_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures test"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

depends "rs_utils"
depends "repo"
depends "repo_svn"

recipe "repo_test::default", "test recipe2"


attribute "repo_test/repository",
  :display_name => "repo_test/repository",
  :description => "repo_test/repository",
  :default => "",
  :recipes => ["repo_test::default"]

attribute "repo_test/revision",
  :display_name => "repo_test/revision",
  :description => "repo_test/revision",
  :default => "",
  :recipes => ["repo_test::default"]

attribute "repo_test/provider_type",
  :display_name => "repo_test/provider_type",
  :description => "repo_test/provider_type",
  :default => "",
  :recipes => ["repo_test::default"]

attribute "repo_test/svn_username",
  :display_name => "repo_test/svn_username",
  :description => "repo_test/svn_username",
  :default => "",
  :recipes => ["repo_test::default"]

attribute "repo_test/svn_password",
  :display_name => "repo_test/svn_password",
  :description => "repo_test/svn_password",
  :default => "",
  :recipes => ["repo_test::default"]

