class LineItem < ActiveRecord::Base

  belongs_to :cart
  belongs_to :product

  # def title was created automatically because you didn't specify a string field
  # when you ran the refinery_engine generator. Love, Refinery CMS.
  def title
    "line item for #{product.name}"
  end
  
  def total_price
    if variant_id.present? and defined?(Variant) and variant.price.present?
      variant.price * quantity
    else
      product.price * quantity
    end
  end
  
  def grand_total
    total = 0
    line_items.each do |li|
      total += li.total_price
    end
    total
  end
  
end
