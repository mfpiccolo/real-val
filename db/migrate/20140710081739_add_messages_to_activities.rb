class AddMessagesToActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :message
    add_column :activities, :messages, :string, array: true, default: '{}'
  end
end
