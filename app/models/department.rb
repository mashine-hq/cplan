# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Department < ApplicationRecord
  belongs_to :user
  has_many :statistics

  validates :name, uniqueness: true, presence: true
  validates_associated :user
  scope :ordered, -> { order(:position, :name) }
  before_validation :set_position

  private
  def set_position
    if self.position.blank?
      self.position = Department.where(user_id: self.user_id).maximum(:position) + 1
    end
  end

end
