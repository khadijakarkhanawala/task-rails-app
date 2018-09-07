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
        a.author_bio = Faker::Lorem.paragraph(2, false, 6)
        a.academics = Faker::Lorem.sentence(3)
        a.awards = Faker::Lorem.sentence(3)
        a.profile_pic = File.open(File.join(Rails.root, "public", "missing-image.png"))

        5.times do
          Book.create do |b|
            b.author_id = a.id
            b.name = Faker::Book.title
            b.short_description = Faker::Lorem.sentence(5, true)
            b.long_description = Faker::Lorem.paragraph(2, true)
            b.publication_date = Faker::Time.between(DateTime.now - 1, DateTime.now)
            b.genre = genres_arr.sample(rand(3))
          end
        end
      end
    end
  end
end