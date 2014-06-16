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
      user_shell     = node[:etc][:passwd]["#{user}"][:shell]
      gid            = node[:etc][:passwd]["#{user}"][:gid]
      uid            = node[:etc][:passwd]["#{user}"][:uid]
      
      directory "#{home_directory}/.percol.d" do
        owner uid
        group gid
        action :create
      end
      
      template "#{home_directory}/.percol.d/rc.py" do
        source "rc.py.erb"
        mode "0744"
        owner uid
        group gid
        not_if  { File.exists?("#{home_directory}/.percol.d/rc.py") }
      end
      
      template "#{home_directory}/.percol.d/zsh_history_search" do
        source "zsh_history_search.erb"
        mode "0744"
        owner uid
        group gid
        not_if  { File.exists?("#{home_directory}/.percol.d/zsh_history_search") }
      end
      
      if /\/zsh$/ =~ user_shell && File.exists?("#{home_directory}/.zshrc")
        bash "percol zsh history search" do 
          code <<-EOC
            echo "[ -f ~/.percol.d/zsh_history_search ] && source ~/.percol.d/zsh_history_search" >> #{home_directory}/.zshrc
          EOC
          not_if "grep '.percol.d/zsh_history_search' ~/.zshrc", :environment => { :'HOME' => "#{home_directory}" } 
        end
      end
    else
      log "user #{user} not found. skipped"
    end
  end
end
