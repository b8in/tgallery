require 'resque_scheduler'
require 'resque_scheduler/server'

Dir["#{Rails.root}/app/workers/*.rb"].each { |file| require file }     # require all workers classes

Resque.redis = 'localhost:6379'

Resque.schedule = YAML.load_file("#{Rails.root}/config/resque_schedule.yml")