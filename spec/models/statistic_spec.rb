# == Schema Information
#
# Table name: statistics
#
#  id            :integer          not null, primary key
#  name          :string
#  units         :string
#  user_id       :integer
#  department_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Statistic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end