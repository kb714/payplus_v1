class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.integer :user_id
      t.string  :secret_key

      t.string  :name
      t.text    :description
      t.string  :img

      t.string :url
      t.string :notify_url

      t.timestamps
    end
  end
end
