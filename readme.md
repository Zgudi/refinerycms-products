# Refinery CMS Products (shopping cart, customers etc.)

Product catalogue for your [Refinery CMS](http://refinerycms.com) website. This version of `refinerycms-products` supports Rails 3.0.x..

If you'd like to have variants (like different shirt sizes) for your products, check out the gem below:

+ Variants - https://github.com/byropig/refinerycms-variants (1.0)

If you would like to be able to assign 'categories' to 'banners', then use the banners engine:

+ Banners - https://github.com/julesce/refinerycms-banners (1.0)

If you would like to use a `product inquiry` instead of a shopping cart please set the following to `true` in the Settings section of Refinery:

    use_product_inquiry

## Requirements

Refinery CMS version 1.0.x.

## Install

Open up your ``Gemfile`` and add the following:

    gem 'refinerycms-products', '~> 1.0.5'

Now, run:

    bundle install

Next, run:

    rails generate acts_as_taggable_on:migration
    rails generate refinerycms_products

This will copy the various migrations and seed files across to your rails app. By default the engine will create a `Products` page. If you don't wish for this page to be created, please edit the `db/seeds/products.rb` seed file.

Once you're happy with your seed data, migrate your database:

    rake db:migrate

## Usage

As mentioned, the `Products` page is created by default. But it is up to you to hook up the front end properly, in terms of creating the relevant links between pages and styling things to your liking. You'll probably want to take a look at the routes to see what you have available:

    bundle exec rake routes

Also note that there are a couple of default images in play, feel free to replace these as necessary.