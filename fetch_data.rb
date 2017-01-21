require 'nokogiri'

def page_url(page_number)
  base_url = "http://www.wegottickets.com/searchresults/page/PAGE_NUMBER/all#paginate"
  page_url = base_url.gsub(/PAGE_NUMBER/, page_number.to_s)
end

def fetch_page(page_url)
end


if $0 == __FILE__
  (1..10).each do |page_number|
    print "\nFetching results for page #{page_number}: "
    url = page_url page_number
    page = fetch_page url
  end
end
