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
  has_many :reports, dependent: :delete_all

  enum data_type: {positive: 0, negative: 1}

  validates_presence_of :user_id, :section_id
  validates :name, :units, presence: true, allow_blank: false

  # interval in ['day', 'week', 'month']
  def graph_data(from = (Time.now - 6.weeks), interval = 'day', label = nil)
    # select sum(units), statistic_id, date_trunc('month', reports.report_at) from reports group by date_trunc('month', reports.report_at), statistic_id order by statistic_id , date_trunc;
    # select sum(units) as units , statistic_id, extract(epoch from date_trunc('month', reports.report_at)) as report_date from reports group by date_trunc('month', reports.report_at), statistic_id order by statistic_id , report_date;
     stat_type = "* -1" if self.negative?
    result = Report.connection.select_all(
      "SELECT extract(epoch from date_trunc('#{interval}', report_at)) * 1000 AS report_date, (sum(units) #{stat_type}) AS \"#{self.name}\", statistic_id
      FROM reports WHERE statistic_id = #{self.id} GROUP BY date_trunc('#{interval}',report_at),statistic_id
      ORDER BY statistic_id, report_date")
    {
      key: label || self.name,
      bar: true,
      values: result.map(&:values)
    }
  end

  def summary_data(from = (Time.now - 6.weeks), label = nil)
    stat_type = "* -1" if self.negative?
    result = Report.connection.select_all(
      "SELECT extract(epoch from report_at) * 1000 AS report_date, (summary #{stat_type}) AS \"#{self.name}\"
      FROM reports WHERE statistic_id = #{self.id}   ORDER BY report_date")
    {
      key: label || self.name,
      values: result.map(&:values)
    }
  end
end
