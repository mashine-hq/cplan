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
  has_many :statistics

  default_scope { order(:department_id, :name) }
  validates :name, presence: true

end
