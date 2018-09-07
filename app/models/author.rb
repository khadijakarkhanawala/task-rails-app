class Author
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  ##Fields
  field :name, type: String
  field :author_bio, type: String
  field :academics, type: String
  field :awards, type: String
  has_mongoid_attached_file :profile_pic,
    :styles => {
      :thumb    => ['100x100']
    },
    :default_url => "missing-image.png"

  validates_attachment_content_type :profile_pic, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  ##Relationships
  has_many :books
end
