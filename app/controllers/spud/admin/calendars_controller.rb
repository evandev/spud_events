class Spud::Admin::CalendarsController < Spud::Admin::ApplicationController
  
  layout 'spud/admin/events/detail'
  add_breadcrumb "Events", :spud_admin_list_spud_calendar_events_path
  add_breadcrumb "Calendars", :spud_admin_spud_calendars_path
  belongs_to_spud_app :events
  
  respond_to :html, :xml, :json, :js

  def new
    @page_name = "New Calendar"
    @calendar = SpudCalendar.new
    respond_with(@calendar)
  end

  def create
    @calendar = SpudCalendar.new(params[:spud_calendar])
    if @calendar.save
      redirect_to spud_admin_spud_calendar_events_path
    else
      render :action => "new"
    end
  end

  def edit
    @page_name = "Edit Calendar"
    @calendar = SpudCalendar.find(params[:id])
    respond_with(@calendar)
  end

  def update
    @calendar = SpudCalendar.find(params[:id])
    if @calendar.update_attributes(params[:spud_calendar])
      flash[:notice] = 'Calendar was successfully updated.'
      redirect_to spud_admin_spud_calendar_events_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @calendar = SpudCalendar.find(params[:id])
    @calendar.spud_calendar_events.each do |event|
      event.update_attribute(:spud_calendar_id, 0)
    end
    @calendar.destroy
    respond_with(@calendar) do |format|
      format.js { render(:nothing => true) }
    end
  end
  
end
