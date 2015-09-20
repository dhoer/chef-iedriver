include_recipe 'java_se'
include_recipe 'selenium::hub'
include_recipe 'iedriver'

node.set['selenium']['node']['capabilities'] = [
  {
    browserName: 'internet explorer',
    maxInstances: 1,
    version: ie_version,
    seleniumProtocol: 'WebDriver'
  }
]
node.set['selenium']['node']['username'] = 'vagrant'
node.set['selenium']['node']['password'] = 'vagrant'

include_recipe 'selenium::node'
