class DisableForumNotifications < ActiveRecord::Migration
  class MemberPreference < ActiveRecord::Base
  end
  def self.up
    MemberPreference.update_all({:forum_notifications => false})
    change_column_default(:member_preferences, :forum_notifications, false)
  end

  def self.down
    change_column_default(:member_preferences, :forum_notifications, true)
  end
end
