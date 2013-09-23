namespace :gallery do
  desc "This task upload images on sever"
  task :upload_images => :environment do
    dir_name = Rails.root.join("db", "seeds", "images")
    if Dir.exists?(dir_name)
      Dir.chdir(dir_name)
      Dir.glob("*") do |subdir|
        if Dir.exists?(Dir.getwd+"/"+subdir) && File.directory?(Dir.getwd+"/"+subdir)
          cat = GImageCategory.find_or_create_by_name(subdir)
          Dir.chdir(Dir.getwd+"/"+subdir)
          Dir.glob("*.{jpg,JPG,jpeg,JPEG,png,PNG,gif,GIF}") do |file|
            if File.file?(Dir.getwd+"/"+file)
              cat.g_images.create(name:file, image: File.open(Dir.getwd+"/"+file))
            end
          end
        end
        Dir.chdir(dir_name)
      end
      puts "\n SUCCESS:  All images are upload. \n\n"
    else
      puts "\nWARNING:  You should create #{dir_name} directory with subdirectories-categories stored images.\n\n"
    end
  end


  desc "upload one image on server"
  task :add_image, [:image_full_name, :category_name] => :environment do |t, args|
    unless !!args.category_name
      GImage.create(name:"file_#{Time.now.to_i%10000}", image: File.open(args.image_full_name, g_image_category_id: nil))
      puts "\n SUCCESS:  Image #{args.image_full_name} is upload without category. \n\n"
    else
      cat = GImageCategory.find_by_name(args.category_name)
      if cat.blank?
        puts "\n ERROR:  Category #{args.category_name} not exists.\n\n "
      else
        r = Random.new
        n = r.rand()*10000 % 10000
        cat.g_images.create(name:"file#{n}", image: File.open(args.image_full_name))
        puts "\n SUCCESS:  Image #{args.image_full_name} is upload in category #{args.category_name}. \n\n"
      end
    end
  end
end