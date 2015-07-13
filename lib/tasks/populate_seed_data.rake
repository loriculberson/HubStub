require 'populator'

desc "Populate the database"

  task :clear_database => :environment do  
    puts "Clearing the datbase....."

     [Category, Image, Venue, Item, User, Order, Event ].each(&:delete_all)
  end

  task :populate_events => :environment do  

    puts "Creating Events...."
    @categories = Category.all

    @categories.each do |category| 
      
      Event.populate 5..20 do |event| 
        event.title    = Faker::Company.catch_phrase
        event.date    =  Faker::Time.between(2.days.from_now, 300.days.from_now)
        event.approved = true
        event.image_id = Image.limit(1).order("RANDOM()").pluck(:id)[0]
        event.venue_id = Venue.limit(1).order("RANDOM()").pluck(:id)[0]
        event.category_id = category.id 
        event.description = event.title
        event.start_time = event.date
      end
    end
    puts "Event total: #{Event.count}"
  end

  task :populate_users => :environment do  
    puts "Creating Users..."

    def unique_email
      begin 
        unique_email = Faker::Internet.email
      end while User.exists?(email: unique_email) 

      unique_email
    end

    def unique_display_name
      begin 
        unique_display_name = Faker::Name.first_name
      end while User.exists?(display_name: unique_display_name)

      unique_display_name
    end

    User.populate 2
    0 do |user| 
      user.full_name = Faker::Name.first_name + " " + Faker::Name.last_name
      user.email = unique_email
      user.password_digest = "password"
      user.display_name = unique_display_name
      user.slug = user.display_name.parameterize 
      user.street_1 = Faker::Address.street_address
      user.city = Faker::Address.city
      user.state = Faker::Address.state
      user.zipcode = Faker::Address.zip_code.scan(/^\d{5}/).first.to_i
    end

      puts "User total: #{User.count}"
  end

  task :populate_items => :environment do
    puts "Creaing Items...."

    delivery_method = ["electronic", "physical"] 
    sold = [true, false]

    Item.populate 10 do |item|
      item.unit_price = Faker::Commerce.price + 1
      item.section    = Faker::Number.between(100, 900)
      item.row        = Faker::Number.between(1, 30)
      item.seat       = Faker::Number.between(1, 25)
      item.user_id    = User.limit(1).order("RANDOM()").pluck(:id)[0]
      item.event_id   = Event.limit(1).order("RANDOM()").pluck(:id)[0]
      item.delivery_method = delivery_method.sample
      item.sold       = sold.sample
    end

    puts "Item total: #{Item.count}"
  end

  task :populate_orders=> :environment do 
    puts "Creating Orders...."

    status = ["ordered", "paid", "completed", "cancelled"]

    Order.populate 10 do |order| 
        user = User.limit(1).order("RANDOM()")[0]
        order.user_id = user.id
        order.status = status.sample
        order.total_price = Faker::Commerce.price + 1
    end
    puts "Order total: #{Order.count}"
  end


  task :all => [ :clear_database, :populate_events, :populate_users, :populate_items, :populate_orders  ]
  Rake::Task["all"].invoke

