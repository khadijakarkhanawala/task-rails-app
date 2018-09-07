class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  ##Fields
  field :author_id, type: Integer
  field :name, type: String
  field :short_description, type: String
  field :long_description, type: String
  field :publication_date, type: Time
  field :genre, type: Array

  ##Relationships
  belongs_to :author
  has_many :reviews
end
