# Refinery CMS Products (shopping cart, customers etc.)

Product catalogue for your [Refinery CMS](http://refinerycms.com) website. This version of `refinerycms-products` supports Rails 3.0.x..

Depends on the following gems, which you'll want to install first:

+ Banners - https://github.com/julesce/refinerycms-banners (1.0)

If you'd like to have variants (like different shirt sizes) for your products, check out the gem below:

+ Variants - https://github.com/byropig/refinerycms-variants (1.0)

## Requirements

Refinery CMS version 1.0.x.

## Install

Open up your ``Gemfile`` and add the following:

    gem 'refinerycms-products', '~> 1.0.0'

Now, run:

    bundle install

Next, run:

    rails generate acts_as_taggable_on:migration
    rails generate refinerycms_products

Migrate your database:

    rake db:migrate

## Usage

It is up to you to hook up the front end, in terms of creating the relevant links between pages and styling things to your liking. You'll probably want to take a look at the routes to see what you have available:

    bundle exec rake routes