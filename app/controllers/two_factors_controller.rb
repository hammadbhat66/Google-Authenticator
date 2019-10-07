class TwoFactorsController < ApplicationController
	before_action :authenticate_user!
require 'rqrcode'
  def new
  end

  # If user has already enabled the two-factor auth, we generate a
  #   temp. otp_secret and show the 'new' template.
  # Otherwise we show the 'show' template which will allow the user to disable
  #   the two-factor auth
  def show
  	puts "sdfsdfsdfagdagergrgaefe43543534543"
    unless current_user.otp_required_for_login?
      current_user.unconfirmed_otp_secret = User.generate_otp_secret
      current_user.save!
      puts two_factor_otp_url
      @qr = generate_qr(two_factor_otp_url) 
      render 'new'
    end
  end

  # AdminUser#activate_two_factor will return a boolean. When false is returned
  #   we presume the model has some errors.
  def create
    permitted_params = params.require(:user).permit :password, :otp_attempt
    User::current=current_user
    if current_user.activate_two_factor permitted_params
      redirect_to root_path, notice: "You have enabled Two Factor Auth"
    else
      render 'new'
    end
  end

  # If the provided password is correct, two-factor is disabled
  def destroy
    permitted_params = params.require(:user).permit :password
    if current_user.deactivate_two_factor permitted_params
      redirect_to root_path, notice: "You have disabled Two Factor Auth"
    else
      render 'show'
    end
  end

  private

  # The url needed to generate the QRCode so it can be acquired by
  #   Google Authenticator
  def two_factor_otp_url
    "otpauth://totp/%{app_id}?secret=%{secret}&issuer=%{app}" % {
      :secret => current_user.unconfirmed_otp_secret,
      :app    => "Hammad",
      :app_id => "Ham"
    }
  end

  def generate_qr(text)
      require 'barby'
  require 'barby/barcode'
  require 'barby/barcode/qr_code'
  require 'barby/outputter/png_outputter'


  barcode = Barby::QrCode.new(text, level: :q, size: 10)
  base64_output = Base64.encode64(barcode.to_png({ xdim: 5 }))
  "data:image/png;base64,#{base64_output}"
  end

end
