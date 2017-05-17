# spec/classes/fankfurt-workshop_spec.rb
require 'spec_helper'
describe 'frankfurt_workshop', :type => :class do
  context 'it should compile on RedHat family' do
    let(:facts) {{
      :osfamily => 'RedHat',
    }}
    it { should compile.with_all_deps }
  end
  context 'it should compile on Debian family' do
    let(:facts) {{
      :osfamily => 'Debian',
    }}
    it { should compile.with_all_deps }
  end
end
