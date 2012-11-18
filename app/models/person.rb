class Person < ActiveRecord::Base
  attr_accessible :birthday, :body_temperature, :can_send_email, :country,
:description, :email, :favorite_time, :graduation_year, :name, :price, :secret

	validates_presence_of :name,
		:message => "must be provided. I won't tell anyone else."
	validates_length_of :name, :in => 3..24
	validates_inclusion_of :country,
		:in => ['Canada', 'US'],
		:message => "must be Canada or US"

	validates_format_of :email,
		:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
		:message => "doesn't look like a proper email address"
	validates_uniqueness_of :email, :case_sensitive => false,
		:message => "belongs to an existing user. Please sign-in."

	validate :description_length_words
	
	def description_length_words
		# only do this validation if description is provided
		unless self.description.blank? then
			# simple way of calculating words: split the text on whitespace
			num_words = self.description.split.length
			if num_words < 5 then
				self.errors.add(:description, "must be at least 5 words long")
				elsif num_words > 50 then
				self.errors.add(:description, "must be at most 50 words long")
			end
		end
	end

end
