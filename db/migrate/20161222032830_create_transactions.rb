class CreateTransactions < ActiveRecord::Migration[5.0]
  def up
    create_table :transactions do |t|
      t.integer :shop_id

      # general information
      t.integer :status, default: 0 # 0: en proceso, 4: aceptada, 6: rechazada
      t.string  :type # webservice, button, email, page
      t.string  :service, default: 'webpayplus' #webpayplus
      t.integer :order
      t.integer :amount

      # client information
      t.string :client_name
      t.string :client_last_name
      t.string :client_id
      t.string :client_email
      t.string :client_phone

      # product information
      t.string  :product_name
      t.text    :product_description
      t.text    :product_shipping_address

      # webpayplus params
      t.string  :id_session
      t.string  :url_return
      t.string  :url_final
      t.string  :token
      t.string  :url_webpay
      t.string  :webpay_error

      # webpayplus response
      t.string  :accounting_date
      t.string  :buy_order
      t.string  :card_number
      t.float   :webpay_amount
      t.string  :commerce_code
      t.string  :authorization_code
      t.string  :payment_type_code
      t.string  :response_code
      t.string  :transaction_date
      t.string  :url_redirection
      t.string  :vci

      t.timestamps
    end
  end

  def down
    drop_table :transactions
  end
end
