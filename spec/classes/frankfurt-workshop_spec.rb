require 'spec_helper'

describe 'frankfurt-workshop', :type => :class do
  on_supported_os.each do |os, facts|
    context "it should compile on #{os}" do
      let(:facts) do
        facts
      end
      it { should compile.with_all_deps }
      it { should contain_package('less') }
      it { should contain_file('/etc/lessrc') }
    end
  end
end
