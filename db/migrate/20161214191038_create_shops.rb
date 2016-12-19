class CreateShops < ActiveRecord::Migration[5.0]
  def up
    create_table :shops do |t|
      t.integer :user_id
      t.string  :secret_key

      t.string      :name
      t.string      :slug
      t.text        :description
      t.attachment  :image

      t.string :url
      t.string :notify_url

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
