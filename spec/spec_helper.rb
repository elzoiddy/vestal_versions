require 'bundler'
Bundler.require
require 'rspec/core'

RSpec.configure do |c|
  c.before(:suite) do
    CreateSchema.suppress_messages{ CreateSchema.migrate(:up) }
  end

  c.after(:suite) do
    FileUtils.rm_rf(File.expand_path('../test.db', __FILE__))
  end

  c.after(:each) do
    VestalVersions::Version.config.clear
    User.prepare_versioned_options({})
  end
end

Dir[File.dirname(__FILE__) + '/support/*.rb'].each { |f| require f }
