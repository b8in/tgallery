class UserNiotifierWorker
  @queue = :email_notifier

  def self.perform(image_id)
    img = GImage.find(image_id)
    unless img.g_image_category.blank?
      subscribed_users = img.g_image_category.users
      subscribed_users.each do |user|
        UserWatchCategory.upload_new_image_mail(img, user.name).deliver
      end
    end
    puts "WORKED!"
  end
end