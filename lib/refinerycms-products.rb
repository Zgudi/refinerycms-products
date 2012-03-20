require 'refinerycms-base'
require 'refinerycms-categories'
require 'refinerycms-customers'
require 'refinerycms-carts'
require 'refinerycms-line_items'
require 'refinery'

module Refinery
  module Products

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end

    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      initializer 'Products.helper' do |app|
        ActionView::Base.send :include, ProductsHelper
      end

      #refinery.after_inclusion do
      #  #Page.send :has_many_page_images
      #  #Product.class_eval { has_many :variants }
      #  #LineItem.class_eval { belongs_to :variant}
      #
      #  #require 'line_item'
      #  #require 'product'
      #
      #  LineItem rescue NameError #this is the ugliest thing ever. Need to reference so it autoloads and then we check for it
      #  Product rescue NameError #this is the ugliest thing ever. Need to reference so it autoloads and then we check for it
      #
      #  puts "******************************** defined?(LineItem)= #{defined?(LineItem)}"
      #  puts "******************************** defined?(Product)= #{defined?(Product)}"
      #
      #  Product.class_eval { has_many :variants }
      #  LineItem.class_eval { belongs_to :variant}
      #
      #  #LineItem.send :include, Refinery::Variants::LineItemExtender
      #  #Product.send :include, Refinery::Variants::ProductExtender
      #end

      #config.to_prepare do
      #  Product.class_eval { has_many :variants }
      #  LineItem.class_eval { belongs_to :variant}
      #end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "products"
          plugin.pathname = root
          plugin.activity = {
            :class => Product,
            :title => 'name'
          }
        end
      end
    end
  end
end
