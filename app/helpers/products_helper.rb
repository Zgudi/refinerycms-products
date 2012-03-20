require 'acts-as-taggable-on'

module ProductsHelper
  include ActsAsTaggableOn::TagsHelper

  def rands(amount)
    number_to_currency(amount, :unit => 'R')
  end

  def rands_nocents(amount)
    number_to_currency(amount, :unit => 'R', :precision => 0)
  end

  def product_or_variant_name(cart_item)
    if variant_exists?(cart_item)
      "#{cart_item.product.name}: #{cart_item.variant.name}"
    else
      cart_item.product.name
    end
  end

  def product_or_variant_price(cart_item)
    if variant_exists?(cart_item)
      rands(cart_item.variant.price)
    else
      rands(cart_item.product.price)
    end
  end

  def cart_item_total(cart_item)
    if variant_exists?(cart_item) and cart_item.variant.price.present?
      rands(cart_item.variant.price * cart_item.quantity)
    else
      rands(cart_item.product.price * cart_item.quantity)
    end
  end

  def variant_exists?(cart_item)
    cart_item.variant_id.present? and defined?(Variant)
  end

end