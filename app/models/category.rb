class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :items, through: :events
  has_many :events

  def self.sort_all
    order(:name)
  end

end
