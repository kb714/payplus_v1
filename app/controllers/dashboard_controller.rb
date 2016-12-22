class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
    #libwebpay = Libwebpay.new
    #certificates = CertNormal.new

    #config = libwebpay.getConfiguration

    #config.commerce_code = certificates.commerce_code
    #config.environment = certificates.environment
    #config.private_key = certificates.private_key
    #config.public_cert = certificates.public_cert
    #config.webpay_cert = certificates.webpay_cert

    #webpay = libwebpay.getWebpay(config)
    #@result = webpay.getNormalTransaction.initTransaction('5000', '808080', 'asdasd', 'https://www.payplus.cl', 'https://www.payplus.cl')
    #render json: "#{result['url']} #{result['token']}"
  end
end
