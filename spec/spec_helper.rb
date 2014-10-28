require 'beaker'
require 'webmock/rspec'

def beaker_base_url
  'http://beaker.dev'
end

def experiment_url test, user_id
  "#{beaker_base_url}/experiments/participate/#{test}/#{user_id}"
end
