# == Schema Information
#
# Table name: addresses
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  company      :string
#  street1      :string           not null
#  street2      :string
#  city         :string           not null
#  zip          :string           not null
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  easy_post_id :string           not null
#

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
