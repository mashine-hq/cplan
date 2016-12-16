# == Schema Information
#
# Table name: reports
#
#  id           :integer          not null, primary key
#  units        :integer
#  report_at    :date
#  summary      :integer
#  statistic_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :report do
    units 1
    report_at "2016-12-16"
    summary 1
    statistic nil
  end
end
