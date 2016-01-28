require 'spec_helper'

describe 'iedriver::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(file_cache_path: 'C:\chef\cache', platform: 'windows', version: '2008R2') do |node|
      ENV['SYSTEMDRIVE'] = 'C:'
      node.set['iedriver']['version'] = '2.45.0'
      allow_any_instance_of(Chef::Recipe).to receive(:ie_version).and_return('11.0.0.0')
      stub_command(
        'netsh advfirewall firewall show rule name="Command line server for the IE Driver" > nul').and_return(false)
    end.converge(described_recipe)
  end

  it 'creates directory' do
    expect(chef_run).to create_directory('C:\iedriver')
  end

  it 'downloads driver' do
    expect(chef_run).to create_remote_file('C:\chef\cache\IEDriverServer_x64_2.45.0.zip').with(
      source: 'https://selenium-release.storage.googleapis.com/2.45/IEDriverServer_x64_2.45.0.zip')
  end

  it 'unzips via powershell' do
    expect(chef_run).to_not run_batch('unzip iedriver')
      .with(code: 'powershell.exe -nologo -noprofile -command "& { Add-Type -A '\
      "'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory("\
      "'C:/chef/cache/IEDriverServer_x64_2.45.0.zip', "\
      "'C:/iedriver/iedriver-2.45.0'); }\"")
  end

  it 'unzips via window_zipfile' do
    expect(chef_run).to_not unzip_windows_zipfile_to('C:\iedriver\iedriver-2.45.0').with(
      source: 'C:\chef\cache\IEDriverServer_x64_2.45.0.zip'
    )
  end

  it 'adds command line firewall rule' do
    expect(chef_run).to run_execute("Firewall rule 'Command line server for the IE Driver'").with(
      command: 'netsh advfirewall firewall add rule name="Command line server for the IE Driver"'\
      ' dir=in profile=private action=allow program="C:\\iedriver\\iedriver-2.45.0\\IEDriverServer.exe"'
    )
  end

  it 'links driver' do
    expect(chef_run).to create_link('C:\iedriver\IEDriverServer.exe').with(
      to: 'C:\iedriver\iedriver-2.45.0\IEDriverServer.exe'
    )
  end

  it 'adds iedriver to path' do
    expect(chef_run).to modify_env('Add iedriver to path').with(
      key_name: 'PATH',
      value: 'C:\iedriver'
    )
  end
end
