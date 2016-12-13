# == Schema Information
#
# Table name: statistics
#
#  id            :integer          not null, primary key
#  name          :string
#  units         :string
#  user_id       :integer
#  department_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Statistic < ApplicationRecord
  belongs_to :user
  belongs_to :department
  validates_associated :user, :department
  validates :name, :units, presence: true, allow_blank: false

end
