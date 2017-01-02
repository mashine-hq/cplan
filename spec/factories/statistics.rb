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
#

FactoryGirl.define do
  factory :statistic do
    name "MyString"
    user nil
    department nil
    units "MyString"
  end
end
