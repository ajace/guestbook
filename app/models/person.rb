class Person < ActiveRecord::Base
  attr_accessible :birthday, :body_temperature, :can_send_email, :country,
:description, :email, :favorite_time, :graduation_year, :name, :price, :secret

	validates_presence_of :name,
		:message => "must be provided. I won't tell anyone else."
	validates_length_of :name, :in => 3..24
	validates_inclusion_of :country,
		:in => ['Canada', 'US'],
		:message => "must be Canada or US"
end
