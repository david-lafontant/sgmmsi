class AddBannedDefaultValuesToUsers < ActiveRecord::Migration[8.0]
  def up
    User.reset_column_information
    User.where(banned: nil).find_each do |user| 
      user.update_attribute(:banned, false)
    end
  end

  def down
    User.reset_column_information  
    User.where(banned: false).find_each do |user|
      user.update_attribute(:banned, nil)
    end
  end
end
