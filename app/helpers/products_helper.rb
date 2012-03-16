require 'acts-as-taggable-on'

module ProductsHelper
  include ActsAsTaggableOn::TagsHelper

  def rands(amount)
    number_to_currency(amount, :unit => 'R')
  end

  def rands_nocents(amount)
    number_to_currency(amount, :unit => 'R', :precision => 0)
  end

end