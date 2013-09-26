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

end
