require 'populator'
require_relative '../../db/seeds/production'

desc "Populate the Production Database"

  task :seed_categories_venues_images_users do
    Seed.call
  end

  task :populate_events do  

    puts "Creating Events...."

    Category.all.each do |category| 
      
      Event.populate 2010 do |event| 
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

  task :populate_users do  
    puts "Creating Users..."

    count = 6
    User.populate 200000 do |user| 
      
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

  
  task :populate_items_for_primary_users do 
    puts "Creaing Items for Primary Users...."

    delivery_method = ["electronic", "physical"] 
    boolean_val = [true, false]

    count_i = 0
    user_ids = [1,2,3,4,5,6]
    events_count    = Event.count

    Item.populate 1000 do |item|
      puts "Item count: #{count_i}"
      item.unit_price = Faker::Commerce.price + 1
      item.section    = Faker::Number.between(100, 900)
      item.row        = Faker::Number.between(1, 30)
      item.seat       = Faker::Number.between(1, 25)
      item.user_id    = user_ids.sample
      item.event_id   = rand(1..events_count)
      item.delivery_method = delivery_method.sample
      item.sold       = boolean_val.sample
      item.pending    = boolean_val.sample
      count_i += 1
    end

    puts "Items for specific users total: #{Item.count}"
  end

  task :populate_items do  
    puts "Creaing Items for Seeded Users...."

    delivery_method = ["electronic", "physical"] 
    boolean_val = [true, false]

    count_i = 0
    users_count     = User.count
    events_count    = Event.count

    Item.populate 499000 do |item|
      puts "Item count: #{count_i}"

      user_ids = rand(1..users_count)
      
      item.unit_price = Faker::Commerce.price + 1
      item.section    = Faker::Number.between(100, 900)
      item.row        = Faker::Number.between(1, 30)
      item.seat       = Faker::Number.between(1, 25)
      item.user_id    = rand(1..users_count)
      item.event_id   = rand(1..events_count)
      item.delivery_method = delivery_method.sample
      item.sold       = boolean_val.sample
      item.pending    = boolean_val.sample
      count_i += 1
    end

    puts "Items for seeded users total: #{Item.count}"
  end

  task :populate_orders_for_primary_users do  
    puts "Creating Orders for Primary Users...."

    status = ["ordered", "paid", "completed", "cancelled"]
    user_order_ids = [1,2,3,4,5,6]

    Order.populate 500 do |order| 
        order.user_id = user_order_ids.sample
        order.status = status.sample
        order.total_price = (Faker::Commerce.price * 1000) + 1
    end
    puts "Order total for Primary Users: #{Order.count}"
  end

  task :populate_orders do  
    puts "Creating Orders for Seeded Users...."

    status_b = ["ordered", "paid", "completed", "cancelled"]
    users_count     = User.count

    Order.populate 45000 do |order| 
      order.user_id = rand(1..users_count)
      order.status = status_b.sample
      order.total_price = (Faker::Commerce.price * 1000)+ 1
    end
    puts "Order total for Primary Users: #{Order.count}"
  end

  task :order_item_primary do  

    counter = 0
    item_count = Item.count

    puts "Creating OrderItems for Primary Users..."
    OrderItem.populate 500 do |orderitem|
      puts "OrderItem count: #{counter}"
      
      user_ids = [1,2,3,4,5,6]
      primary_user_order_ids = Order.where(user_id: user_ids).pluck(:id)
      orderitem.item_id = rand(1..item_count)
      orderitem.order_id = primary_user_order_ids.sample
      
      counter +=1
    end
    puts "OrderItem total for Primary Users: #{OrderItem.count}"
  end

  task :order_item do  
    counter = 0
    puts "Creating OrderItems..."
      item_count  = Item.count
      order_count = Order.count

    OrderItem.populate 20000 do |orderitem|
      puts "OrderItem count: #{counter}"
      orderitem.item_id = rand(1..item_count)
      orderitem.order_id = rand(1..order_count)

      counter +=1
    end
    puts "OrderItem total: #{OrderItem.count}"
  end

  task :all => [  :environment, :seed_categories_venues_images_users, :populate_events, 
                  :populate_users, :populate_items_for_primary_users, :populate_items, 
                  :populate_orders_for_primary_users, :populate_orders, :order_item_primary, 
                  :order_item 
                ]

