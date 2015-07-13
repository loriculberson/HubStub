class Seed

  def call
    generate_categories
    generate_venues
    generate_images
  end

  VENUE_DESCRIPTORS =   ["Park", "Arena", "Stadium", "Hall", "Ampitheatre",
                        "School", "Opera House", "Center", "Pavilion", "Field"]

  def generate_categories
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

    p "Categories created"
  end

  def generate_venues
   100.times do |i|
      venue_type = VENUE_DESCRIPTORS[i % VENUE_DESCRIPTORS.length]

      Venue.create(
        name: Faker::Company.name + "#{venue_type}", 
        location: Faker::Address.city + ", " + Faker::Address.state
      )
    end
    p "Venues created"
  end

  def generate_images
    300.times do 
      Image.create(
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.sentence 
      )
    end
    p "Images created"
  end


  def self.call
    new.call
  end
end



