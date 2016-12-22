class Transaction::WebPayPlusController < ApplicationController
  require_relative('../../views/certificates/certnormal')
  skip_before_filter :verify_authenticity_token, :only => [:result, :end]

  def button
    @button = Shop.find_by(id: params[:shop_id]).buttons.find_by(button_slug: params[:button_slug])
    if request.post?
      @transaction = Transaction.new(webpay_params)
      # move to model ---
      @transaction.amount = @button.price
      @transaction.order = rand(11111111..99999999)
      @transaction.url_return = 'http://app.payplus.cl/webpay/result'
      @transaction.url_final = 'http://app.payplus.cl/webpay/end'
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
    webpay = set_webpay

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
    @token = params[:token_ws]
    @transaction = Transaction.find_by(token: @token)
    webpay = set_webpay
    @result = webpay.getNormalTransaction.getTransactionResult(@transaction.token)
    if @result['error_desc'] == 'TRX_OK'
      @transaction.accounting_date     = @result['accountingdate']
      @transaction.buy_order           = @result['buyorder']
      @transaction.card_number         = @result['cardnumber']
      @transaction.webpay_amount       = @result['amount']
      @transaction.commerce_code       = @result['commercecode']
      @transaction.authorization_code  = @result['authorizationcode']
      @transaction.payment_type_code   = @result['paymenttypecode']
      @transaction.response_code       = @result['responsecode']
      @transaction.transaction_date    = @result['transactiondate']
      @transaction.url_redirection     = @result['urlredirection']
      @transaction.vci                 = @result['vci']
      @transaction.save
    end
  end

  def end
    @params = params
  end

  private

  def webpay_params
    params.require(:transaction).permit(:client_name, :client_last_name, :client_email, :client_phone)
  end

  def set_webpay
    libwebpay = Libwebpay.new
    certificates = CertNormal.new

    config = libwebpay.getConfiguration

    config.commerce_code = certificates.commerce_code
    config.environment = certificates.environment
    config.private_key = certificates.private_key
    config.public_cert = certificates.public_cert
    config.webpay_cert = certificates.webpay_cert

    libwebpay.getWebpay(config)
  end
end
