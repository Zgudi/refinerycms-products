# Refinery CMS Products and Categories

Product catalogue (with categories) for your [Refinery CMS](http://refinerycms.com) website. Depends on the following gems, which you'll want to install first:

+ Banners - https://github.com/julesce/refinerycms-banners (1.0)

This version of `refinerycms-products` supports Rails 3.0.x.

## Requirements

Refinery CMS version 1.0.x.

## Install

Open up your ``Gemfile`` and add the following:

    gem 'refinerycms-products', '~> 1.0.0'

Now, run:

    bundle install

Next, run:

    rails generate acts_as_taggable_on:migration
    rails generate refinerycms_categories
    rails generate refinerycms_products

Migrate your database:

    rake db:migrate