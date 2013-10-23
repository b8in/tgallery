#require 'uri'
ActiveAdmin.register_page 'ImagesParser' do

  menu priority: 2, label: "Images Parser" #proc{ I18n.t("active_admin.images_parser") }

  #####################################################################################
  page_action :parse, method: :post do
    from_curr = "USD"
    to_curr = "UAH"
    amount =100
    doc = Nokogiri::HTML(open("http://www.google.com/finance/converter?a=#{amount}&from=#{from_curr}&to=#{to_curr}"))
    res = "Today 100$ equal to #{doc.css('span.bld').text}"
    redirect_to :back, notice: res
  end

  action_item do
    link_to "100$", admin_imagesparser_parse_path, method: :post
  end
  #####################################################################################

  page_action :parse_cats, method: :post do
    NEW_IMAGES_LIMIT = 5
    new_images_count = 0
    category = GImageCategory.where(name: 'cats').first
    parsing_url = params[:imagesparser][:url]
    doc = Nokogiri::HTML(open(parsing_url))
    elems = doc.css('div#img-list div.cell img')
    elems.each do |elem|
      data_href = URI.unescape(elem['data-href'])
      img_link = data_href[21..-5]
      img_name = img_link.rpartition('/')[2]
      if category.g_images.where(name: img_name).blank?
        img = category.g_images.build(name:img_name)
        img.remote_image_url = "http://#{img_link}"
        if img.save
          new_images_count += 1
        end
        break if new_images_count >= NEW_IMAGES_LIMIT
      end
    end

    redirect_to admin_images_path, notice: "upload #{new_images_count} new images in category 'Cats'."
  end

  content title: 'Images Parser from web-sites' do
    div id: "parser-panel" do
      form action: admin_imagesparser_parse_cats_path, method: :post do
        input name: 'authenticity_token', type: :hidden, value: form_authenticity_token.to_s
        label 'URL for parsing'
        input type: :text_field, id: 'imagesparser_url', name: 'imagesparser[url]',
              value: 'http://search.photo.qip.ru/search/?query=cats', readonly: true, size: 60
        input type: :submit, value: 'PARSE'
      end
    end # parser-panel
  end
end
