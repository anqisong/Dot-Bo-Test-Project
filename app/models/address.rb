class Address < ActiveRecord::Base
  validates :name, :easy_post_id, :street1, :city, :state, :country, :zip, presence: true
end
