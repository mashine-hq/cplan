# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  enabled    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ApplicationRecord
  belongs_to :user
  has_many :statistics, dependent: :nullify

  validates :name, :user_id, presence: true, allow_blank: false

end
