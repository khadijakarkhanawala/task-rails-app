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
    :default_url => "images/image_5.jpg"

  validates_attachment_content_type :profile_pic, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  ##Relationships
  has_many :books

  ##Methods
  def profile_pic_url
    {
      thumb: profile_pic.url(:thumb)
    }
  end

  def id_string
    id.to_s
  end

  def self.get_search_data search_term
    or_cond = [];  
  
    or_cond << {:name => /#{search_term}.*/i};
    or_cond << {:author_bio => /#{search_term}.*/i};
  
    all_cond = {"$or" => or_cond}
        
    authors = Author.where(all_cond).as_json(only: [:name, :author_bio, :academics, :awards], 
      methods: [:profile_pic_url, :id_string], include: {
        books: {only: [:name, :short_description, :genre], methods: [:published_date, :id_string], include: {
          reviews: {except: [:_id, :book_id, :created_at, :updated_at], methods: [:id_string]}
        }}
      })

    return authors
  end
end
