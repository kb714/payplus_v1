class Transaction::WebPayPlusController < ApplicationController
  require_relative('../../views/certificates/certnormal')

  def button
    @button = Shop.find_by(id: params[:shop_id]).buttons.find_by(button_slug: params[:button_slug])
    if request.post?
      @transaction = Transaction.new(webpay_params)
      # move to model ---
      @transaction.amount = @button.price
      @transaction.order = rand(11111111..99999999)
      @transaction.url_return = 'https://app.payplus.cl/webpay/result'
      @transaction.url_final = 'https://www.payplus.cl/webpay/end'
      # -----------------
      if @transaction.valid?
        @transaction.save
        prepare(@transaction.id)
      else
        render action: :button
      end
    else
      @transaction = Transaction.new
    end
  end

  def prepare(transaction_id)
    libwebpay = Libwebpay.new
    certificates = CertNormal.new

    config = libwebpay.getConfiguration

    config.commerce_code = certificates.commerce_code
    config.environment = certificates.environment
    config.private_key = certificates.private_key
    config.public_cert = certificates.public_cert
    config.webpay_cert = certificates.webpay_cert

    webpay = libwebpay.getWebpay(config)

    @transaction = Transaction.find_by(id: transaction_id)

    @result = webpay.getNormalTransaction.initTransaction(
        @transaction.amount,
        @transaction.order,
        'TEST',
        @transaction.url_return,
        @transaction.url_final
    )
    if @result['error_desc'] == 'TRX_OK'
      @transaction.token = @result['token']
      @transaction.save
    end
    render 'transaction/web_pay_plus/prepare.html.haml'
  end

  def result

  end

  def end

  end

  private

  def webpay_params
    params.require(:transaction).permit(:client_name, :client_last_name, :client_email, :client_phone)
  end
end
