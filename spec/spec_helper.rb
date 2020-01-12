require "volunteer"
require "project"
require "rspec"
require "pry"
require "pg"

# SHOULD CONSIDER MOVING THIS TO BEFORE EACH CONFIG BECAUSE RSPEC WOULD DELETE FROM ALL IN WRONG DB.
# DB = PG.connect({:dbname => 'volunteer_tracker_test'})

RSpec.configure do |config|
  config.before(:each) do
    # DB = PG.connect({:dbname => 'volunteer_tracker_test'})
  end

  config.after(:each) do
    DB.exec('DELETE FROM volunteers *;')
    DB.exec('DELETE FROM projects *;')
  end
end
