class ApergeiaFeedCell < Cell::Rails

	require 'nokogiri'
	require 'open-uri'

	def index
		begin
			@doc = Nokogiri::HTML(open("http://www.apergia.gr/q/index.php?id=today"))
			render
		rescue
			@doc = nil
		end
	end

end
