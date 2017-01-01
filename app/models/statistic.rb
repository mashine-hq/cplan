# == Schema Information
#
# Table name: statistics
#
#  id         :integer          not null, primary key
#  name       :string
#  units      :string
#  user_id    :integer
#  section_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Statistic < ApplicationRecord
  belongs_to :user
  belongs_to :section

  validates_associated :user, :section
  validates :name, :units, presence: true, allow_blank: false

end
