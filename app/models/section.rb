# == Schema Information
#
# Table name: sections
#
#  id            :integer          not null, primary key
#  department_id :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  enabled       :boolean          default(TRUE), not null
#

class Section < ApplicationRecord
  belongs_to :department
  has_many :statistics, dependent: :destroy

  default_scope { order(:department_id, :name, :enabled) }
  scope :enabled, -> { where(enabled: true) }
  validates :name, presence: true

end
