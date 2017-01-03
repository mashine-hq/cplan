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

require 'rails_helper'

RSpec.describe Statistic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
