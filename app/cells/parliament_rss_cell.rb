class ParliamentRssCell < Cell::Rails

	require 'rss'

	def index
		begin
			@parliament_rss = RSS::Parser.parse(open('http://www.hellenicparliament.gr/rssfeed/RssNews.aspx?catid=573EB3FF-7DC6-44C9-9969-58284F0951E3').read, false).items[0...10]
			render
		rescue 
			# Do nothing, just continue.  The view will skip the blog section if the feed is nil.
			@parliament_rss = nil
		end
	end

end
