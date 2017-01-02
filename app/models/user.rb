# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  role                   :integer
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :integer
#  invitations_count      :integer          default(0)
#  phone                  :string
#  provider               :string
#  uid                    :string
#

class User < ApplicationRecord
  enum role: [:owner, :worker]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :departments
  has_many :statistics
  has_many :products

  after_initialize :set_default_role, :if => :new_record?
  validates :phone, phone: {possible: true, allow_blank: true, types: [:mobile]}
  scope :workers, ->(user_id) { where(invited_by_id: user_id).order(:name) }

  def set_default_role
    self.role ||= :owner
  end

  def has_departments?
    self.departments.count > 0
  end

  def has_products?
    self.products.count > 0
  end

  def has_workers?
    User.workers(self.id).count > 0
  end

  def has_statistics?
    self.statistics.count > 0
  end

  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end

  #https://github.com/zquestz/omniauth-google-oauth2#auth-hash
  def self.find_for_google_oauth2(auth_hash, signed_in_resource=nil)
    data = auth_hash.info
    # {
    #   :name => "John Doe",
    #   :email => "john@company_name.com",
    #   :first_name => "John",
    #   :last_name => "Doe",
    #   :image => "https://lh3.googleusercontent.com/url/photo.jpg"
    # },
    user = User.where(provider: auth_hash.provider, uid: auth_hash.uid).first
    unless user
      registered_user = User.where(email: auth_hash.info.email).first
      user = registered_user ? registered_user :
        User.create(name: data['name'],
                    provider: auth_hash.provider,
                    email: data['email'],
                    uid: auth_hash.uid,
                    password: Devise.friendly_token[0, 20])
    end
    user
  end

end
