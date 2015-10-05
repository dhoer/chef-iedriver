require 'serverspec_helper'

describe 'iedriver::default' do
  if os[:family] == 'windows'
    describe file('C:/iedriver/IEDriverServer.exe') do
      it { should be_file }
    end
  end
end
