module Merchants::ShopsHelper
  def show_identifier(shop)
    shop.identifier.present? ? "#{SiteConfig.app_base_url}/#{shop.identifier}" : "Please pick an appropriate identifier for your shop example"
  end

  def show_business_category_names(shop)
    shop.business_category_names.present? ? shop.business_category_names.join(", ") : 'Please add appropriate categories for your business and we will suggest you to the clients interested in those categories'
  end

  def show_website(shop)
    shop.website.present? ? link_to(shop.website, shop.website) : "Please enter your business website"
  end

  def show_description(shop)
    shop.description.present? ? shop.description.html_safe : "Please enter the nature of your business for the your customers"
  end

  def show_logo(shop)
    shop.logo_img.present? ? image_tag(shop.logo_img.url) : "Please update your Logo"
  end
end