class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :two_factor_authenticatable,
         :otp_secret_encryption_key => "This is the encryption key Please Change it with Environment variable"
  devise :registerable,
         :recoverable, :rememberable, :validatable
         belongs_to :role

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user]=user
  end


  def activate_two_factor params
  otp_params = { otp_secret: unconfirmed_otp_secret }
  if !valid_password?(params[:password])
    errors.add :password, :invalid
    false
  elsif !validate_and_consume_otp!(params[:otp_attempt], otp_params)
    errors.add :otp_attempt, :invalid
    false
  else
    activate_two_factor!
  end
end

def deactivate_two_factor params
  if !valid_password?(params[:password])
    errors.add :password, :invalid
    false
  else
    self.otp_required_for_login = false
    self.otp_secret = nil
    save
  end
end

private

def activate_two_factor!
  self.otp_required_for_login = true
  puts User.current.email
  puts User.current.unconfirmed_otp_secret
  self.otp_secret = User.current.unconfirmed_otp_secret
  self.unconfirmed_otp_secret = nil
  save
end
end
