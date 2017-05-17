# Puppet Testing Workshop

Frankfurt/Main - 17.05.2017

## System preparation

On a VM or on your local machine: install rvm or rbenv

Get used to Ruby
- gems
- irb

Make your irb better usable:

    gem install wirble

Create your .irbrc file

    require 'rubygems'
    require 'wirble'
    Wirble.init
    Wirble.colorize

## Start with styleguide checks

    gem install puppet-lint

Run lint tests

    puppet-lint <manifests file>

Check for extensions on http://voxpupuli.org

## Continue with rspec-puppet tests

    gem install rspec-puppet

Create rspec-puppet required files

    rspec-puppet-init

Modify spec/spec_helper.rb

    # spec/spec_helper.rb
    require 'rspec-puppet'
    fixture_path = File.expand_path(File.join(__FILE__,'..','fixtures'))
    RSpec.configure do |c|
      c.module_path = File.join(fixture_path, 'modules')
      c.manifest_dir = File.join(fixture_path, 'manifests')
    end

Add a first spec test in spec/classes/frankfurt-workshop_spec.rb

    # spec/classes/frankfurt-workshop_spec.rb
    require 'spec_helper'
    describe 'frankfurt-workshop', :type => :class do
      context 'it should compile' do
        it { should compile.with_all_deps }
      end
    end

Run rspec:

    rake rspec

Analyze and fix errors

## Working in a separate installation directory

Don't mess your ruby !!

Uninstall all prior installed gems:

    gem uninstall puppet-lint rspec-puppet

Install bundler

    gem install bundler

Install gems

    bundle install --path vendor

Adopt Rakefile

    # Rakefile
    require 'puppetlabs_spec_helper/rake_tasks'

Run rake -T with bundler

    bundle exec rake -T
    bundle exec rake spec

## How to add required modules?

Depending modules are added to .fixtures.yml file:

    # .fixtures.yml
    fixtures:
      symlinks:
        'frankfurt-workshop': "#{source_dir}"
      repositories:
        'stdlib':
          repo: 'https://github.com/puppetlabs/puppetlabs-stdlib.git',
          ref: '4.16'

## How to test on other OS?

Install the puppet facts gem via bundler:

    # Gemfile add the following line:
    gem 'rspec-puppet-facts'

Install gem using bundler:

    bundle install --path vendor

Attention: this one needs a metadata.json file!

    {
      "name": "tuxmea/frankfurt-workshop",
      "version": "1.0.0",
      "author": "frankfurt workshop",
      "summary": "code for puppet testing workshop",
      "license": "Apache-2.0",
      "source": "https://github.com/tuxmea/frankfurt-workshop",
      "project_page": "https://github.com/tuxmea/frankfurt-workshop",
      "issues_url": "https://github.com/tuxmea/frankfurt-workshop/issues",
      "tags": ["workshop", "frankfurt", "puppet testing"],
      "operatingsystem_support": [
        {
          "operatingsystem":"RedHat",
          "operatingsystemrelease":[ "6.x", "7.x" ]
        },
        {
          "operatingsystem":"CentOS",
          "operatingsystemrelease":[ "6.x", "7.x" ]
        },
        {
          "operatingsystem": "Ubuntu",
          "operatingsystemrelease": [ "14.04" ]
        },
        {
          "operatingsystem": "Debian",
          "operatingsystemrelease": [ "8.x" ]
        }
      ],
      "dependencies": [
        { "name": "puppetlabs/stdlib", "version_requirement": "> 5.0" },
      ]
    }

Now update your rspec code:

    # spec/classes/frankfurt-workshop.rb
    require 'spec_helper'
    describe 'frankfurt-workshop', :type => :class do
      on_supported_os.each do |os, facts|
        context "it should compile on #{os}" do
          let(:facts) do
            facts
          end
          it { should compile.with_all_deps }
        end
      end
    end

## Beaker

Install beaker

    bundle install --path vendor --with-integration

Run beaker integration tests

    bundle exec rake beaker

Add tests in spec/acceptance/frankfurt-workshop_spec.rb

    # spec/acceptance/frankfurt-workshop_spec.rb

Tests with docker:

if you have worked as non-root (which is more nice)

    sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
    sudo yum install -y puppet-agent
    sudo puppet module install puppetlabs-docker
    sudo puppet apply -e 'include docker'


## Retrospec

Install retrospec

    gem install puppet-retrospec

Get a module without tests (e.g. remove spec folder, Rakefile, Gemfile, .fixtures.yml from this repo

Run retrospec

    retrospec -m <modulepath>

Check results

Done.


