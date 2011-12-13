class DisableForumNotifications < ActiveRecord::Migration
  def self.up
    change_column_default(:member_preferences, :forum_notifications, false)
  end

  def self.down
    change_column_default(:member_preferences, :forum_notifications, true)
  end
end
