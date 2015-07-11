class RemovePaperclipTicketAttachment < ActiveRecord::Migration
  def change
    remove_column :items, :ticket_file_name, :string
    remove_column :items, :ticket_content_type, :string
    remove_column :items, :ticket_file_size, :integer
    remove_column :items, :ticket_updated_at, :datetime

    add_column :items, :ticket, :string, default: "http://www.urartuuniversity.com/content_images/pdf-sample.pdf"

  end
end
