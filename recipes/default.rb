#
# Cookbook Name:: percol
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "python::#{node['python']['install_method']}"
include_recipe "python::pip"
include_recipe "python::virtualenv"

python_pip "percol" do
  action :install
end

if node[:percol][:users].any?
  node[:percol][:users].each do |user|
    if node[:etc][:passwd]["#{user}"]
      home_directory = node[:etc][:passwd]["#{user}"][:dir]
      user_shell     = node[:etc][:passwd]["#{user}"][:dir]
      log "HOME=#{home_directory}"
      log "SHELL=#{user_shell}"
    end
  end
end
