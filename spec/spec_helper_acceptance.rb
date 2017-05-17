require 'beaker-rspec'

hosts.each do |host|
  # Install Puppet
  install_puppet
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do

    hosts.each do |host|
      # Install module
      copy_module_to(host, :source => proj_root, :module_name => 'frankfurt-workshop', :target_module_path => '/etc/puppetlabs/code/modules')

      # Install dependencies
      on host, puppet('module','install','puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
