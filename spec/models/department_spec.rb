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
#  enabled    :boolean          default(TRUE), not null
#

require 'rails_helper'

RSpec.describe Department, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
