class AddEventUrlToSpudCalendarEvent < ActiveRecord::Migration
  def change
    add_column :spud_calendar_events, :event_url, :string
  end
end
