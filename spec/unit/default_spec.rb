require 'spec_helper'

describe 'iedriver_test::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      file_cache_path: 'C:/chef/cache', platform: 'windows', version: '2008R2').converge(described_recipe)
  end

  it 'creates directory' do
    expect(chef_run).to create_directory('C:/iedriver/iedriver-2.47.0')
  end

  it 'downloads driver' do
    expect(chef_run).to create_remote_file('C:/chef/cache/IEDriverServer_x64_2.47.0.zip').with(
      source: 'https://selenium-release.storage.googleapis.com/2.47/IEDriverServer_x64_2.47.0.zip')
  end

  it 'unzips via powershell' do
    expect(chef_run).to_not run_batch('unzip iedriver')
      .with(code: "powershell.exe -nologo -noprofile -command \"& { Add-Type -A "\
      "'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory("\
      "'C:/chef/cache/IEDriverServer_x64_2.47.0.zip', "\
      "'C:/iedriver/iedriver-2.47.0'); }\"")
  end

  it 'unzips via window_zipfile' do
    expect(chef_run).to_not unzip_windows_zipfile_to('C:/iedriver/iedriver-2.47.0').with(
      source: 'C:/chef/cache/IEDriverServer_x64_2.47.0.zip'
    )
  end

  it 'links driver' do
    expect(chef_run).to create_link('C:/iedriver/iedriver').with(
      to: 'C:/iedriver/iedriver-2.47.0'
    )
  end
end
