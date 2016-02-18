# Selenium IEDriver Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/iedriver.svg?style=flat-square)][supermarket]
[![Build Status](http://img.shields.io/travis/dhoer/chef-iedriver.svg?style=flat-square)][travis]

[supermarket]: https://supermarket.chef.io/cookbooks/iedriver
[travis]: https://travis-ci.org/dhoer/chef-iedriver

Installs IEDriverServer (https://github.com/SeleniumHQ/selenium/wiki/InternetExplorerDriver) and 
configures Internet Explorer.

## Requirements

- Internet Explorer 9+
- Chef 11.16+

### Platforms

- Windows

### Cookbooks

- ie 
- windows

## Usage

Include recipe in cookbook or run list to install IEDriverServer and configure Internet Explorer.

### Attributes

- `node['iedriver']['version']` - Version to download.
- `node['iedriver']['url']` -  Download URL prefix.
- `node['iedriver']['home']` - Home directory. Default `%SYSTEMDRIVE%\iedriver`.
- `node['iedriver']['config_ie']` - Configure Internet Explorer according to 
[required configuration](https://github.com/SeleniumHQ/selenium/wiki/InternetExplorerDriver#required-configuration).
Default `true`.

### Example

#### Install selenium node with internet explorer capability

```ruby
include_recipe 'iedriver'

node.set['selenium']['node']['capabilities'] = [
  {
    browserName: 'internet explorer',
    maxInstances: 1,
    version: ie_version,
    seleniumProtocol: 'WebDriver'
  }
]
node.set['selenium']['node']['username'] = 'username'
node.set['selenium']['node']['password'] = 'password'
node.set['selenium']['node']['domain'] = 'domain'

include_recipe 'selenium::node'
```

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/ie+webdriver).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-iedriver/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-iedriver/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-iedriver/blob/master/LICENSE.md) file for details.
