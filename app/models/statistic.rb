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
#  product_id :integer
#  data_type  :integer          default("positive"), not null
#

class Statistic < ApplicationRecord
  belongs_to :user
  belongs_to :section
  belongs_to :product, optional: true

  enum data_type: {positive: 0, negative: 1}

  validates_presence_of :user_id, :section_id
  validates :name, :units, presence: true, allow_blank: false

end
