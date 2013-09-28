class UserWatchCategory < ActionMailer::Base
  default from: Settings.mailer.user_name
  default subject: "Adding new image to subscribed category"

  def upload_new_image_mail(image, username)        #FIXME: remove & fix commentable code
    @image = image
    @user_name = username
    #puts "00000000000000000000000000000000000  #{Rails.root}"+'/public'+@image.image.url(:thumb)
    attachments['image.jpg'] = "#{Rails.root}/public"+@image.image.url(:thumb)
    mail(to: Settings.mailer.user_name)  #user.email
  end

  def send_notification_email(img_categories, user_name, user_email)
    fresh_image_time = 24.hours.ago
    @user_name = user_name
    @new_images = {}
    img_categories.each do |category|
      imgs = category.g_images.where("created_at > :time", time: fresh_image_time)
      @new_images[category.name] = imgs
      imgs.each do |img|
        attachments[img.name] = "#{Rails.root}/public"+img.image.url(:thumb)
      end
    end
    puts "...  send email to #{@user_name}, <#{user_email}>"
    mail(to: Settings.mailer.user_name) #user_email
  end

end
