class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  ##Fields
  field :book_id, type: Integer
  field :reviewer_name, type: String
  field :rating, type: Integer
  field :title, type: String
  field :description, type: String

  ##Relationships
  belongs_to :book
end
