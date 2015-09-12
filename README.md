# IEDriver Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/iedriver.svg?style=flat-square)][supermarket]
[![Build Status](http://img.shields.io/travis/dhoer/chef-iedriver.svg?style=flat-square)][travis]
[![GitHub Issues](http://img.shields.io/github/issues/dhoer/chef-iedriver.svg?style=flat-square)][github]

[supermarket]: https://supermarket.chef.io/cookbooks/iedriver
[travis]: https://travis-ci.org/dhoer/chef-iedriver
[github]: https://github.com/dhoer/chef-iedriver/issues

Installs IEDriver and configures IE.

## Requirements

- Chef 11 or higher

### Platforms

- Windows

### Cookbooks

- ie 
- windows - used only when PowerShell 3 or greater is not installed

## Usage

Include recipe in cookbook or run list to install IEDriver and configures IE.

### Attributes

- `node['iedriver']['home']` - The location of the IE driver home directory. Defaults to `C:/iedriver`.
- `node['iedriver']['config_ie']` - Configure Internet Explorer according to 
[required configuration](https://github.com/SeleniumHQ/selenium/wiki/InternetExplorerDriver#required-configuration).
Defaults to `true`.

### Example

#### Install selenium-grid node with Internet Explorer capability

```ruby
include_recipe 'iedriver::default'

node.set['selenium']['node']['capabilities'] = [
   {
    browserName: 'internet explorer',
    maxInstances: 1,
    seleniumProtocol: 'WebDriver'
  }
]
  
include_recipe 'selenium::node'
```

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef-iedriver).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-iedriver/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-iedriver/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-iedriver/blob/master/LICENSE.md) file for details.
