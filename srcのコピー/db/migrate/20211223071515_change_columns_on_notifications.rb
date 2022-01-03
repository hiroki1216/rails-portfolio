class ChangeColumnsOnNotifications < ActiveRecord::Migration[6.1]
  def change
    add_reference :notifications, :post, foreign_key: true 
    add_reference :notifications, :comment, foreign_key: true 
    add_reference :notifications, :message, foreign_key: true 
    add_column :notifications, :action, :string
  end
end
