class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  ##Fields
  field :author_id, type: Integer
  field :name, type: String
  field :short_description, type: String
  field :long_description, type: String
  field :publication_date, type: Date
  field :genre, type: Array
  field :chapter_index, type: Array

  ##Relationships
  belongs_to :author
  has_many :reviews

  ##Methods

  def published_date
    publication_date.strftime("%d %B, %Y")
  end

  def id_string
    id.to_s
  end

  def self.get_search_data search_term
    or_cond = [];  
  
    or_cond << {:name =>  /#{search_term}.*/i};
    or_cond << {:short_description => /#{search_term}/i};
    or_cond << {:long_description => /#{search_term}/i};
    or_cond << {:genre => {'$in' =>  search_term.split(" ").map{|tag|/#{tag}/i}}};
  
    all_cond = {"$or" => or_cond}
        
    books = Book.where(all_cond).as_json(only: [:name, :short_description, :long_description, :genre], 
      methods: [:published_date, :id_string], include: {
        author: {only: [:name, :author_bio], methods: [:profile_pic_url, :id_string]}, 
        reviews: {except: [:_id, :book_id, :created_at, :updated_at], methods: [:id_string]}
    })

    return books
  end
end
