require 'capybara/poltergeist'

class HubStub
  attr_reader :session

  def initialize
    @session ||= Capybara::Session.new(:poltergeist)
  end

  def eventids
    Event.count
  end

  def run #start of the test
    loop do
      visit_root
      create_new_account
      click_adventure
      buy_ticket
      # click_buy_then_add_ticket_to_cart
      logout
      login
      sell_an_item
    end
  end

  def visit_root
    # session.visit 'https://selling-tickets.herokuapp.com'
    session.visit 'http://localhost:3000'
    puts 'Nice web page!'
  end

  def create_new_account
    session.click_link "Sign up"
    session.fill_in 'user[full_name]', with: "Wendy Smith"
    session.fill_in 'user[display_name]', with: "Wendy"
    session.fill_in "user[email]", with: "MCProdigy@gmail.com"
    session.fill_in 'user[street_1]', with: "123 Lala Lane"
    session.fill_in 'user[city]', with: "The Windy City"
    session.fill_in 'user[zipcode]', with: "92345" 
    session.select "Alabama", from: 'user[state]'
    session.fill_in'user[password]', with: "password" 
    session.fill_in'user[password_confirmation]', with: "password" 

    session.click_button 'Create my account'
    puts "Created account"
  end

  def login
    session.click_link("Login")
    session.fill_in "session[email]", with: 'lori@example.com'
    session.fill_in "session[password]", with: 'password'
    session.click_link_or_button("Log in")
    puts "Login complete"
  end

  def click_adventure
    session.click_link("Adventure")
  end

  def buy_ticket
    # session.first(:button, 'Add to Cart').click
    session.all(:css, "input.btn").sample.click
    session.click_link("Cart(1)")
    session.click_link("Checkout")
    session.fill_in "session[email]", with: 'lori@example.com'
    session.fill_in "session[password]", with: 'password'
    session.click_link_or_button("Log in")
    session.click_button("Submit Order")
    puts "Got me a Ticket"
  end

  def click_buy_then_add_ticket_to_cart
    session.click_link 'Buy'
    session.click_link 'All Tickets'
    session.all("tr.event-row").first.click 
    session.all(:css, "input.btn").sample.click
    puts "Add event ticket to cart"
  end

  def logout
    session.click_link("Logout")
    puts "Drop the mike!"
  end

  def sell_an_item
    session.click_link 'Sell'
    session.all(:css, "#item_event_id").sample.click
    session.fill_in 'item[section]', with: "A"
    session.fill_in 'item[row]', with: "A"
    session.fill_in 'item[seat]', with: "A"
    session.fill_in 'item[unit_price]', with: 100
    session.select "Physical", from: 'item[delivery_method]'
    session.click_on "List Ticket"
    puts "Sell an item"
  end














end
