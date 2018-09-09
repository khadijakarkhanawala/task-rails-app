class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  ##Fields
  field :book_id, type: Integer
  field :reviewer_name, type: String
  field :rating, type: Integer, default: 0
  field :title, type: String
  field :description, type: String

  ##Relationships
  belongs_to :book

  ##Validations
  validates :reviewer_name, :rating, :presence => true
  validates :rating, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5}

  ##Methods
  def id_string
    id.to_s
  end
end
