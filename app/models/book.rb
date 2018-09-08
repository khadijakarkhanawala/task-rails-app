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

  def self.get_search_data search_term
    or_cond = [];  
  
    or_cond << {:name =>  /#{search_term}.*/i};
    or_cond << {:short_description => /#{search_term}/i};
    or_cond << {:long_description => /#{search_term}/i};
    or_cond << {:genre => {'$in' =>  search_term.split(" ").map{|tag|/#{tag}/i}}};
  
    all_cond = {"$or" => or_cond}
        
    books = Book.where(all_cond).as_json(except: [:publication_date, :author_id, :created_at, :updated_at, :chapter_index], 
      methods: [:published_date], include: {
        author: {only: [:name], methods: [:profile_pic_url]}, 
        reviews: {except: [:created_at, :updated_at]}
    })

    return books
  end
end
