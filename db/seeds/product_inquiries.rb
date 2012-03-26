if defined?(User)
  User.all.each do |user|
    if user.plugins.where(:name => 'product_inquiries').blank?
      user.plugins.create(:name => 'product_inquiries',
                          :position => (user.plugins.maximum(:position) || -1) +1)
    end
  end
end

if defined?(::Page)
  page_position = (::Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)

  contact_us_page = ::Page.create({
                                      :title => "Product Inquiry",
                                      :link_url => "/product_inquiry",
                                      :menu_match => "^/product_inquiry.*$",
                                      :show_in_menu => false,
                                      :deletable => false,
                                      :position => (page_position += 1)
                                  })
  contact_us_page.parts.create({
                                   :title => "Body",
                                   :body => "<p>Get in touch with us. Just use the form below and we'll get back to you as soon as we can.</p>",
                                   :position => 0
                               })

  contact_us_page_position = -1

  thank_you_page = contact_us_page.children.create({
                                                       :title => "Thank You",
                                                       :link_url => "/product_inquiry_thank_you",
                                                       :menu_match => "^/product_inquiry_thank_you$",
                                                       :show_in_menu => false,
                                                       :deletable => false,
                                                       :position => (contact_us_page_position += 1)
                                                   })
  thank_you_page.parts.create({
                                  :title => "Body",
                                  :body => "<p>We've received your inquiry and will get back to you with a response shortly.</p><p><a href='/'>Return to the home page</a></p>",
                                  :position => 0
                              })
end