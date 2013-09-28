require 'resque_scheduler'

Resque.redis = 'localhost:6379'

#Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }