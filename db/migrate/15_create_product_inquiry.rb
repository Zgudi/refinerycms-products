class CreateProductInquiry < ActiveRecord::Migration

  def self.up
    create_table :product_inquiries do |t|
      t.references :product
      t.string   "name"
      t.string   "email"
      t.string   "phone"
      t.text     "message"
      t.boolean  "spam",       :default => false
      t.timestamps
    end

    add_index :product_inquiries, :product_id

    load(Rails.root.join('db', 'seeds', 'product_inquiries.rb'))
  end

  def self.down
    if defined?(UserPlugin)
      UserPlugin.destroy_all({:name => "product_inquiries"})
    end

    drop_table :product_inquiries
  end

end
