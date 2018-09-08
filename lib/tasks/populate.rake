namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do 
    require 'faker'

    Rake::Task['db:reset'].invoke
    genres_arr = ["Science Fiction", "Satire", "Drama", "Action and Adventure", "Romance", "Mystery", "Horror", "Self Help", "Fantasy"]
    

    # Create 15 posts
    100.times do
      Author.create do |a|
        a.name = Faker::Name.unique.name
        a.author_bio = Faker::Lorem.paragraph(rand(1..2), true, rand(1..6))
        a.academics = Faker::Lorem.sentence(rand(1..3))
        a.awards = Faker::Lorem.sentence(rand(1..3))
        a.profile_pic = File.open(File.join(Rails.root, "public", "missing-image.png"))
      end
    end

    authors = Author.all
    authors.each do |author|
      5.times do
        Book.create do |b|
          b.author_id = author.id
          b.name = Faker::Book.unique.title
          b.short_description = Faker::Lorem.sentence(rand(3..5), true)
          b.long_description = Faker::Lorem.paragraph(rand(1..5), true, rand(1..4))
          b.publication_date = Faker::Time.between(DateTime.now - 1, DateTime.now)
          b.genre = genres_arr.sample(rand(1..3))
          chapter_index = []
          (0..rand(10..20)).each do |i|
            if i == 0
              page_no = 5
            else
              previous_chap = chapter_index[i-1]
              page_no = previous_chap[:page_no]+rand(50)
            end
            chapter_index.push({:id => i, :name => Faker::Lorem.sentence(rand(1..5)), :page_no => page_no})
          end
          b.chapter_index = chapter_index
        end
      end
    end

    books1 = Book.order_by(["name", "desc"]).limit(50)

    books1.each do |book|
      2.times do
        Review.create do |r|
          r.book_id = book.id
          r.rating = rand(5)
          r.reviewer_name = Faker::Name.unique.name
          r.title = Faker::Lorem.sentence(rand(1..3), true)
          r.description = Faker::Lorem.paragraph(rand(1..7), true, rand(1..4))
        end
      end
    end

    books2 = Book.order_by(["created_at", "desc"]).limit(150)

    books2.each do |book|
      Review.create do |r|
        r.book_id = book.id
        r.rating = rand(5)
        r.reviewer_name = Faker::Name.unique.name
        r.title = Faker::Lorem.sentence(rand(1..3), true)
        r.description = Faker::Lorem.paragraph(rand(1..7), true, rand(1..4))
      end
    end
  end
end