#
# Cookbook Name:: cakephp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "#{node[:cakephp][:dir]}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

cakephp_dir = "cakephp-#{node[:cakephp][:version]}"

remote_file "#{Chef::Config[:file_cache_path]}/#{cakephp_dir}.tar.gz" do
  source "http://github.com/cakephp/cakephp/archive/#{node[:cakephp][:version]}.tar.gz"
end

execute "tar zxvf #{Chef::Config[:file_cache_path]}/#{cakephp_dir}.tar.gz --strip 1" do
  cwd node[:cakephp][:dir]
  #creates "#{node[:cakephp][:dir]}"
end

link "/usr/bin/cake" do
  to "#{node[:cakephp][:dir]}/lib/Cake/Console/cake"
  action :create
end

link "/usr/share/php/Cake" do
  to "#{node[:cakephp][:dir]}/lib/Cake"
  action :create
end