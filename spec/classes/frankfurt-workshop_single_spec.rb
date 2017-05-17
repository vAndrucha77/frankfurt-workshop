# spec/classes/fankfurt-workshop_spec.rb
require 'spec_helper'
describe 'frankfurt-workshop', :type => :class do
  context 'it should compile' do
    it { should compile.with_all_deps }
  end
end
