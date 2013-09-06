# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
class GImageCategory < ActiveRecord::Base
  attr_accessible :name
end

GImageCategory.destroy_all
#puts 'GImageCategory is empty = ' + "#{!GImageCategory.first}"
GImageCategory.create(name: 'tits')
GImageCategory.create(name: 'cats')
GImageCategory.create(name: 'alcohol')
GImageCategory.create(name: 'christmas')
GImageCategory.create(name: 'ruby')