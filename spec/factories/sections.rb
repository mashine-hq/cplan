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

FactoryGirl.define do
  factory :section do
    department ""
    name "MyString"
  end
end
