if defined?(User)
  RefinerySetting.find_or_set(:product_inquiry_recipients, User.first.email)
end

RefinerySetting.find_or_set(:use_product_inquiry, false)