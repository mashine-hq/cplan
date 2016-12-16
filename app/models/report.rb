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

class Report < ApplicationRecord
  belongs_to :statistic
  validates :units, :report_date, presence: true
  before_create :set_summary

  private
  def set_summary
    self.report_date ||= Date.current
    self.summary = Report.where(statistic_id: self.statistic_id).sum(:units) + self.units
  end
end
