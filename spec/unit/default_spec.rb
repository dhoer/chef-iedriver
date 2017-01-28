require 'spec_helper'

describe 'iedriver::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(file_cache_path: 'C:\chef\cache', platform: 'windows', version: '2008R2') do |node|
      ENV['SYSTEMDRIVE'] = 'C:'
      node.override['iedriver']['version'] = '3.0.0'
      allow_any_instance_of(Chef::Recipe).to receive(:ie_version).and_return('11.0.0.0')
      stub_command(
        'netsh advfirewall firewall show rule name="Command line server for the IE Driver" > nul'
      ).and_return(false)
    end.converge(described_recipe)
  end

  it 'creates directory' do
    expect(chef_run).to create_directory('C:\iedriver')
  end

  it 'downloads driver' do
    expect(chef_run).to create_remote_file('C:\chef\cache\IEDriverServer_x64_3.0.0.zip').with(
      source: 'https://selenium-release.storage.googleapis.com/3.0/IEDriverServer_x64_3.0.0.zip'
    )
  end

  it 'unzips via powershell' do
    expect(chef_run).to_not run_powershell_script('unzip C:\chef\cache\IEDriverServer_x64_3.0.0.zip')
  end

  it 'adds command line firewall rule' do
    expect(chef_run).to run_execute("Firewall rule 'Command line server for the IE Driver'").with(
      command: 'netsh advfirewall firewall add rule name="Command line server for the IE Driver"'\
      ' dir=in profile=private action=allow program="C:\\iedriver\\iedriver-3.0.0\\IEDriverServer.exe"'
    )
  end

  it 'links driver' do
    expect(chef_run).to create_link('C:\iedriver\IEDriverServer.exe').with(
      to: 'C:\iedriver\iedriver-3.0.0\IEDriverServer.exe'
    )
  end

  it 'adds iedriver to path' do
    expect(chef_run).to modify_env('Add iedriver to path').with(
      key_name: 'PATH',
      value: 'C:\iedriver'
    )
  end
end
