name 'iedriver'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Selenium WebDriver for Internet Explorer'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.1'

supports 'windows'

depends 'ie', '~> 2.0'
depends 'windows', '~> 1.0'

source_url 'https://github.com/dhoer/chef-iedriver' if respond_to?(:source_url)
issues_url 'https://github.com/dhoer/chef-iedriver/issues' if respond_to?(:issues_url)
