class User < ApplicationRecord
  enum role: [:owner, :worker]
  after_initialize :set_default_role, :if => :new_record?
  validates :phone, phone: {possible: true, allow_blank: true, types: [:mobile]}

  def set_default_role
    self.role ||= :owner
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end
end
