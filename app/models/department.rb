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
#  enabled    :boolean          default(TRUE), not null
#

class Department < ApplicationRecord
  belongs_to :user
  has_many :sections

  validates :name, uniqueness: true, presence: true
  validates_associated :user
  before_validation :set_position

  scope :ordered, -> { order(:position, :name) }
  default_scope { order(:position) }

  private
  def set_position
    if self.position.blank?
      self.position = self.user.departments.maximum(:position).to_i + 1
    end
  end

end
