##require 'carrierwave'
#require_relative '../../app/uploaders/image_uploader'
#require_relative '../../app/models/painting'
#
#namespace :gallery do
#  #desc "This task upload one image on sever"
#  task :upload_image => :environment do |t, args|
#
#    #i = GImage.new
#    #i.image = File.open(args.image_name)
#    #puts i.save
#
#    puts ":::::::::::::::::::::::::::::::::::: #{args.image_name}"
#    p = Painting.new
#    p.image = args[0]  #File.open(args.image_name)
#    p.GImageCategory_id= 1
#    p.name= "name"
#    p.save
#  end
#
#  task :qq => :environment do
#
#    #i = GImage.new
#    #i.image = File.open(args.image_name)
#    #puts i.save
#
#    puts ":::::::::::::::::::::::::::::::::::: "
#    p = Painting.new
#    #p.image = args.image_name  #File.open(args.image_name)
#    #p.GImageCategory_id= 1
#    #p.name= "name"
#    #p.save
#  end
#end