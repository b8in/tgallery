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
  task :add_image, [:category_name, :image_full_name] => :environment do |t, args|
    cat = GImageCategory.find_by_name(args.category_name)
    if cat.blank?
      puts "\n ERROR:  Category #{args.category_name} not exists.\n "
    else
      r = Random.new
      n = r.rand()*10000 % 10000
      cat.g_images.create(name:"file#{n}", image: File.open(args.image_full_name))
    end
  end
end