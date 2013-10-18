class HomesController < ApplicationController

  def change_locale
    puts "##################################   #{params[:new_locale]}"
    if ['ru', 'en'].include?(params[:new_locale])
      I18n.locale = params[:new_locale]
      puts "1"
    else
      I18n.locale = I18n.default_locale
      puts "2"
    end
    puts I18n.locale
    redirect_to params[:back_url]
  end

  def index
    @categories = GImageCategory.includes(:g_images).reverse_order.limit(6)
    @comments = UserComment.includes(e_history: [:user], g_image: [:g_image_category]).order(:created_at).reverse_order.limit(5)

    gon.pusher_config = Webs.pusher_config
  end

end
