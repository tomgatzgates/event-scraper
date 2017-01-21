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

def event_id(result_html)
  result_html.at_css('h2 a')['href'].match(/[0-9]+$/).to_s.to_i
end

def parse_result(result_html)
  event = Event.new
  event.id = event_id result_html

  event
end

if $0 == __FILE__
  (1..10).each do |page_number|
    print "\nFetching results for page #{page_number}: "
    url = page_url page_number
    page = fetch_page url
    results = fetch_results page
  end
end
