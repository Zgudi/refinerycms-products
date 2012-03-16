require 'refinerycms-base'
require 'refinerycms-categories'
require 'refinerycms-customers'
require 'refinerycms-carts'
require 'refinerycms-line_items'

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
