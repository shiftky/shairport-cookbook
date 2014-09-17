#
# Cookbook Name:: shairport
# Recipe:: shairport
#
# Copyright 2014, shiftky
#
# All rights reserved - Do Not Redistribute
#

packages = %w(git libao-dev libssl-dev libcrypt-openssl-rsa-perl libio-socket-inet6-perl libwww-perl avahi-utils libmodule-build-perl pkg-config)
packages.each do|pkg|
  package pkg do
    action :install
  end
end

git "/tmp/shairport" do
  repository "https://github.com/hendrikw82/shairport.git"
  revision "master"
  action :sync
end

bash 'make and make install shairport' do
  user 'root'
  code <<-EOC
    cd /tmp/shairport
    make
    make install
  EOC
  creates "/usr/local/bin/shairport"
end

cpan_client 'Net::SDP' do
  action :install
  install_type 'cpan_module'
  user 'root'
  group 'root'
end

template "/etc/init.d/shairport" do
  source "shairport.erb"
  owner "root"
  group "root"
  mode "755"
end

service "shairport" do
  supports restart: true
  action [ :enable, :start ]
end
