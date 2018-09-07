namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do 
    require 'faker'

    Rake::Task['db:reset'].invoke
    
    # Create 15 posts
    100.times do
      Author.create do |a|
        a.name = Faker::Name.unique.name
        a.author_bio = Faker::Lorem.paragraph(2, false, 6)
        a.academics = Faker::Lorem.sentence(3)
        a.awards = Faker::Lorem.sentence(3)
        a.profile_pic = File.open(File.join(Rails.root, "public", "missing-image.png"))

        5.times do
          Book.create do |a|
            field :name, type: String
            field :short_description, type: String
            field :long_description, type: String
            field :publication_date, type: Time
            field :genre, type: Array
          end
        end
      end
    end
  end
end