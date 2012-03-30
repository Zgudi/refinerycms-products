class Category < ActiveRecord::Base

  include Rails.application.routes.url_helpers 

  acts_as_indexed :fields => [:name]

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :parent_id

  belongs_to :parent, :class_name => "Category", :foreign_key => "parent_id" 
  has_many :children, :class_name => "Category", :foreign_key => "parent_id"

  has_and_belongs_to_many :products

  if defined?(Banner)
    has_and_belongs_to_many :banners
  end

  # Docs for acts_as_nested_set https://github.com/collectiveidea/awesome_nested_set
  acts_as_nested_set :dependent => :destroy # rather than :delete_all
  
  def title
    name
  end
  
  def url
    category_products_path(id)
  end
end
