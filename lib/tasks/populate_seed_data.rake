 namespace :db do 
  desc "Erase and fill database"
  task :populate => :environment do  
    require 'populator'

    @categories = Category.all

    @categories.each do |category| 
      
      Event.populate 20..200 do |event|  #test dataset
        event.title    = Faker::Lorem.sentence(3)
        event.date    =  Faker::Time.between(2.days.from_now, 300.days.from_now)
        event.approved = true
        event.image_id = Image.limit(1).order("RANDOM()").pluck(:id)[0]
        event.venue_id = Venue.limit(1).order("RANDOM()").pluck(:id)[0]
        event.category_id = category.id 
        event.description = event.title + "Event"
        event.start_time = event.date
      end
    end
  end
end



    # [Category, Venue, Image, Event, Item].each(&:delete_all)
      #Each category will be populated with bt 500 and 2000 events
      #yield 7500 to 30,000 events total 
      # Event.populate 500..2000 do |event|  #dream dataset
        # Faker::Date.between(2.days.from_now, 300.days.from_now)
    #create users 200,000
    #
