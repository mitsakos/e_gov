class ApergeiaFeedCell < Cell::Rails

	require 'nokogiri'
	require 'open-uri'

	def index
		@doc = Nokogiri::HTML(open("http://www.apergia.gr/q/index.php?id=today"))
		render
	end

end
