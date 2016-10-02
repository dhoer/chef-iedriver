name 'iedriver'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Selenium WebDriver for Internet Explorer'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://github.com/dhoer/chef-iedriver'
issues_url 'https://github.com/dhoer/chef-iedriver/issues'
version '2.0.0'

chef_version '>= 12.6'

supports 'windows'

depends 'ie', '~> 2.0'
