class EventsCell < Cell::Rails

  def index
  	@events = Event.all
  	@date = params[:month] ? Date.parse(params[:month].gsub('-','/')) : Date.today
    render
  end

end
