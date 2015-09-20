if platform?('windows')
  version = node['iedriver']['version']
  iedriver_dir = "#{node['iedriver']['home']}\\iedriver-#{version}"

  directory node['iedriver']['home'] do
    action :create
  end

  bit = node['kernel']['machine'] == 'x86_64' ? 'x64' : 'Win32'
  zip = "#{Chef::Config[:file_cache_path]}\\IEDriverServer_#{bit}_#{version}.zip"

  # Fixes windows_zipfile rubyzip failure to allocate memory (requires PowerShell 3 or greater & .NET Framework 4)
  batch 'unzip iedriver' do
    code "powershell.exe -nologo -noprofile -command \"& { Add-Type -A 'System.IO.Compression.FileSystem';"\
      " [IO.Compression.ZipFile]::ExtractToDirectory('#{zip}', '#{iedriver_dir}'); }\""
    action :nothing
    only_if { iedriver_powershell_version >= 3 }
  end

  windows_zipfile iedriver_dir do
    source zip
    action :nothing
    not_if { iedriver_powershell_version >= 3 }
  end

  remote_file zip do
    source "#{node['iedriver']['url']}/#{iedriver_short_version(version)}/IEDriverServer_#{bit}_#{version}.zip"
    not_if { ::File.exist?("#{iedriver_dir}/IEDriverServer.exe") }
    notifies :run, 'batch[unzip iedriver]', :immediately if platform?('windows')
    notifies :unzip, "windows_zipfile[#{iedriver_dir}]", :immediately if platform?('windows')
  end

  link "#{node['iedriver']['home']}\\IEDriverServer.exe" do
    to "#{iedriver_dir}\\IEDriverServer.exe"
  end

  env 'PATH' do
    action :modify
    delim ::File::PATH_SEPARATOR
    value node['iedriver']['home']
  end

  include_recipe 'iedriver::config_ie' if node['iedriver']['config_ie']
else
  Chef::Log.warn("IEDriverServer cannot be installed on #{node['platform']} platform!")
end
