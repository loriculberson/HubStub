require 'populator'
# require 'bcrypt'
require_relative '../../db/seeds/development'

desc "Populate the database"

  task :clear_database_dev  do
    puts "Clearing the database....."
    system("rake db:drop db:create db:migrate")
  end

  task :seed_categories_venues_images_users_dev do
    Seed.call
  end

  task :populate_events_dev  do  

    puts "Creating Events...."

    Category.all.each do |category| 
      
      Event.populate 250..1000 do |event| 
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

  task :populate_users_dev => :environment do  
    puts "Creating Users..."

    count = 6
    User.populate 50000 do |user| 
      
      puts "User count: #{count}"
      user.full_name = Faker::Name.first_name + " " + Faker::Name.last_name
      user.email = Faker::Internet.email
      user.password_digest = "$2a$04$TCIUgh88IS5/CCtieDmTn.DkChX3HJz5rV/s4FfgrLW1p8mCo8lhW"
      user.display_name = Faker::Name.first_name
      user.slug = user.display_name.parameterize 
      user.street_1 = Faker::Address.street_address
      user.city = Faker::Address.city
      user.state = Faker::Address.state
      user.zipcode = Faker::Address.zip_code.scan(/^\d{5}/).first.to_i
      count += 1
    end

      puts "User total: '#{User.count}'"
  end

  task :populate_items_dev  do
    puts "Creaing Items...."

    delivery_method = ["electronic", "physical"] 
    boolean_val = [true, false]

    count_i = 0
    Item.populate 250000 do |item|
      puts "Item count: #{count_i}"
      item.unit_price = Faker::Commerce.price + 1
      item.section    = Faker::Number.between(100, 900)
      item.row        = Faker::Number.between(1, 30)
      item.seat       = Faker::Number.between(1, 25)
      item.user_id    = User.limit(1).order("RANDOM()").pluck(:id)[0]
      item.event_id   = Event.limit(1).order("RANDOM()").pluck(:id)[0]
      item.delivery_method = delivery_method.sample
      item.sold       = boolean_val.sample
      item.pending    = boolean_val.sample
      count_i += 1
    end

    puts "Item total: #{Item.count}"
  end

  task :populate_orders_dev => :environment do
     
    puts "Creating Orders...."

    status = ["ordered", "paid", "completed", "cancelled"]
    user_choices = [1,2,3,4,5,6]
    Order.populate 500 do |order|
      order.user_id = user_choices.sample
      order.status = status.sample
      order.total_price = (Faker::Commerce.price * 1000) + 1
    end
    puts "Order total: #{Order.count}"
  end

  task :order_item_dev => :environment do
    counter = 0
    puts "Creating OrderItems..."
    OrderItem.populate 500 do |orderitem|
      puts "OrderItem count: #{counter}"
      orderitem.item_id = rand(1..Item.count)
      user_ids = User.limit(6).pluck(:id)
      orderitem.order_id = Order.where(user_id: user_ids).order("RANDOM()").limit(1).pluck(:id)[0]
      
      counter +=1
    end
    puts "OrderItem total: #{OrderItem.count}"
  end

  task :all_dev => [  :environment, :clear_database, :seed_categories_venues_images_users_dev, :populate_events_dev, 
                      :populate_users_dev, :populate_items_dev, :populate_orders_dev, :order_item_dev 
                    ]


