class Seed

  def call
    generate_categories
    generate_venues
    generate_images
    generate_users_a
  end

  VENUE_DESCRIPTORS =   ["Park", "Arena", "Stadium", "Hall", "Ampitheatre",
                        "School", "Opera House", "Center", "Pavilion", "Field"]

  def generate_categories
    puts "Creating Categories...."
    Category.create([
      { name: "Sports" },
      { name: "Music" },
      { name: "Theater" },
      { name: "Photography Class" },
      { name: "Family" },
      { name: "Theme Parks" },
      { name: "Car Show" },
      { name: "Gun Shows" },
      { name: "Wine Tasting" },
      { name: "Haunted House Tours" },
      { name: "Pub Crawls" },
      { name: "Histroic Homes Tours" },
      { name: "Hot Air Ballooning" },
      { name: "Movies" },
      { name: "Livestock & Rodeo" }
    ])

    p "Category total: #{Category.count}"
  end

  def generate_venues
    puts "Creating Venues....."
   100.times do |i|
      venue_type = VENUE_DESCRIPTORS[i % VENUE_DESCRIPTORS.length]

      Venue.create(
        name: Faker::Company.name + " #{venue_type}", 
        location: Faker::Address.city + ", " + Faker::Address.state
      )
    end
    p "Venue total: #{Venue.count}"
  end

  def generate_images
    puts "Creating Images...."
    100.times do 
      Image.create(
        title: Faker::Commerce.product_name,
        description: Faker::Lorem.sentence 
      )
    end
    p "Image total: #{Image.count}"
  end

  def generate_users_a
    @users = User.create!([
       { full_name:            "Lori Smile",
        email:                 "lori@example.com",
        password:              "password",
        password_confirmation: "password",
        street_1:              "123 Main St.",
        city:                  "Denver",
        state:                 "CO",
        zipcode:               80203,
        display_name:          "lori"},
      { full_name:             "Rachel Warbelow",
        email:                 "demo+rachel@example.com",
        password:              "password",
        password_confirmation: "password",
        street_1:              "1111 Downing St.",
        street_2:              "Apt. 101",
        city:                  "Denver",
        state:                 "CO",
        zipcode:               80203,
        display_name:          "rwarbelow"},
      { full_name:             "Jeff Casimir",
        email:                 "demo+jeff@example.com",
        password:              "password",
        password_confirmation: "password",
        street_1:              "1111 Downing St.",
        street_2:              "Apt. 101",
        city:                  "Denver",
        state:                 "CO",
        zipcode:               80203,
        display_name:          "j3"},
      { full_name:             "Jorge Tellez",
        email:                 "demo+jorge@example.com",
        password:              "password",
        password_confirmation: "password",
        street_1:              "1111 Downing St.",
        street_2:              "Apt. 101",
        city:                  "Denver",
        state:                 "CO",
        zipcode:               80203,
        display_name:          "novohispano"},
      { full_name:             "Bill Gates",
        email:                 "bill@gates.com",
        password:              "password",
        password_confirmation: "password",
        street_1:              "1111 Downing St.",
        city:                  "Seattle",
        state:                 "WA",
        zipcode:               90329,
        display_name:          "thebillgates"},
      { full_name:             "Taylor Swift",
        email:                 "taytay@swift.com",
        password:              "password",
        password_confirmation: "password",
        street_1:              "1111 Downing St.",
        street_2:              "Apt. 101",
        city:                  "Denver",
        state:                 "CO",
        zipcode:               80203,
        display_name:          "taylorswift13"},
    ])
  end


  def self.call
    new.call
  end
end



