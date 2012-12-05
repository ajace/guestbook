class Post < ActiveRecord::Base
  attr_accessible :description

  belongs_to :person
end
