class User < ApplicationRecord
  enum role: [:owner, :worker]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :owner
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
