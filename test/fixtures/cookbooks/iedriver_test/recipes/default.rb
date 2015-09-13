# TODO: remove when selenium 3.x is released
node.set['selenium']['windows']['java'] = 'C:\java\bin\java.exe'

include_recipe 'java_se::default'

include_recipe 'selenium::hub'

include_recipe 'iedriver::default'

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
