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

REQUIRED_DATA = {
  id: {
    method: lambda { |node| node['href'].match(/[0-9]+$/).to_s.to_i },
    mapping: 'h2 a',
  },
  artist: {
    method: lambda { |node| node.text.strip.split.map(&:capitalize).join(' ') },
    mapping: 'h2',
  },
  city: {
    method: lambda { |node| node.text.split(':')[0].strip.capitalize },
    mapping: "h4",
  },
  venue: {
    method: lambda { |node| node.text.split(':')[1..-1].join(' ').strip.split.map(&:capitalize).join(' ') },
    mapping: "h4",
  },
}

def parse_result(result_html)
  event = Event.new

  REQUIRED_DATA.each_pair do |attribute, helpers|
    fn = helpers[:method]
    node = result_html.at_css(helpers[:mapping])

    event[attribute] = !!node ? fn.call(node) : nil
  end

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
