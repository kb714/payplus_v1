class CreateButtons < ActiveRecord::Migration[5.0]
  def up
    create_table :buttons do |t|
      t.integer   :shop_id

      # general information
      t.string  :name
      t.string  :button_slug
      t.text    :description
      t.text    :retirement_address
      t.string  :qr

      # Price, stock and delivery information
      t.integer :price
      t.integer :charge
      t.boolean :is_stock, default: false
      t.integer :stock
      t.boolean :home_delivery # permit home delivery?

      t.timestamps
    end
  end

  def down
    drop_table :buttons
  end
end
