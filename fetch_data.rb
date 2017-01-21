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

MAPPINGS = {
  event_id: 'h2 a',
  artist: 'h2',
  city: 'h4',
  venue: 'h4',
}

def event_id(result_html)
  result_html.at_css(MAPPINGS[:event_id])['href'].match(/[0-9]+$/).to_s.to_i
end

def artist(result_html)
  result_html.at_css(MAPPINGS[:artist])
    .text.strip.split.map(&:capitalize).join(' ')
end

def city(result_html)
  result_html.at_css(MAPPINGS[:city]).text.split(':')[0].strip.capitalize
end

def venue(result_html)
  result_html.at_css(MAPPINGS[:venue])
    .text
    .split(':')[1..-1]
    .join(' ')
    .strip
    .split
    .map(&:capitalize)
    .join(' ')
end

def parse_result(result_html)
  event = Event.new

  event.id = event_id result_html
  event.artist = artist result_html
  event.city = city result_html
  event.venue = venue result_html

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
