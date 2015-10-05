require 'rspec'
require 'selenium-webdriver'

WINDOWS = RbConfig::CONFIG['host_os'] =~ /mingw|mswin/

RSpec.configure { |c| c.formatter = 'documentation' }
