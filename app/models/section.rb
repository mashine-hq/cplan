# == Schema Information
#
# Table name: sections
#
#  id            :integer          not null, primary key
#  department_id :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Section < ApplicationRecord
  belongs_to :department
  has_many :statistics

  validates :name, presence: true

end
