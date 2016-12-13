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

FactoryGirl.define do
  factory :department do
    user nil
    name "MyString"
    position 1
  end
end
