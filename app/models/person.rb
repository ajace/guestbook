class Person < ActiveRecord::Base
	attr_accessible :birthday, :body_temperature, :can_send_email, :country,
	:description, :email, :favorite_time, :graduation_year, :name, :price, :photo

	after_save :store_photo

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

	has_many :posts
	
	def description_length_words
		unless self.description.blank? then
			num_words = self.description.split.length
			if num_words < 5 then
				self.errors.add(:description, "must be at least 5 words long")
				elsif num_words > 50 then
				self.errors.add(:description, "must be at most 50 words long")
			end
		end
	end

  PHOTO_STORE = File.join Rails.root, 'public', 'photo_store'
  
  def photo=(file_data)
    unless file_data.blank?
      @file_data = file_data
      self.extension = file_data.original_filename.split('.').last.downcase
    end
  end
  
  def has_photo?
    File.exists? photo_filename
  end
  
  def photo_path
    "/photo_store/#{id}.#{extension}"
  end
  
  def photo_filename
    File.join PHOTO_STORE, "#{id}.#{extension}"
  end
   
  private
  def store_photo
    if @file_data
      FileUtils.mkdir_p PHOTO_STORE
      File.open(photo_filename, 'wb') do |f|
        f.write(@file_data.read)
      end
      
      @file_data = nil
    end
  end
end
