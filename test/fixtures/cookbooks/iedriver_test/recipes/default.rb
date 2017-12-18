include_recipe 'java_se'
include_recipe 'selenium::hub'
include_recipe 'iedriver'

node.default['selenium']['node']['capabilities'] = [
  {
    browserName: 'internet explorer',
    maxInstances: 1,
    version: ie_version,
    seleniumProtocol: 'WebDriver'
  }
]
# node.default['selenium']['node']['username'] = 'vagrant'
# node.default['selenium']['node']['password'] = 'vagrant'

include_recipe 'selenium::node'
