require 'capybara/poltergeist'

desc "Simulate load against Selling Tickets application"
task :load_test => :environment do
  1.times.map { Thread.new { HubStub.new.run } }.map(&:join)
end
