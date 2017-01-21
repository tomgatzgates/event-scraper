require 'nokogiri'
require 'open-uri'

def page_url(page_number)
  base_url = "http://www.wegottickets.com/searchresults/page/PAGE_NUMBER/all#paginate"
  page_url = base_url.gsub(/PAGE_NUMBER/, page_number.to_s)
end

def fetch_page(page_url)
  Nokogiri::HTML(open(page_url))
end

def fetch_results(document)
  document.css('div.content.chatterbox-margin')
end

Event = Struct.new :id, :artist, :city, :venue, :date, :price

def parse_result(result_html)
  event = Event.new
end

if $0 == __FILE__
  (1..10).each do |page_number|
    print "\nFetching results for page #{page_number}: "
    url = page_url page_number
    page = fetch_page url
    results = fetch_results page
  end
end
