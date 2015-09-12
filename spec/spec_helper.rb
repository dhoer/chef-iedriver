require 'chefspec'
require 'chefspec/berkshelf'
require_relative '../libraries/default'

Chef::Config[:chef_gem_compile_time] = false
ChefSpec::Coverage.start!
