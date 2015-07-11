class AddPhotoUrlToImage < ActiveRecord::Migration
  def change
    add_column :images, :photo, :string, default: "https://literaryyard.files.wordpress.com/2015/01/crowd.jpg"

  end
end
