require_relative 'fetch_data'

describe '#page_url' do
  it 'returns the correct url with page number' do
    expect(page_url 1).to eq "http://www.wegottickets.com/searchresults/page/1/all#paginate"
    expect(page_url 5).to eq "http://www.wegottickets.com/searchresults/page/5/all#paginate"
  end
end

describe '#fetch_page' do
  it 'should return a nokogiri html document' do
    sample_page = 'sample_results.html'

    result = fetch_page sample_page
    expect(result.class).to eq Nokogiri::HTML::Document
  end
end

describe '#fetch_results' do
  it 'returns array of XML Elements' do
    sample = Nokogiri::HTML(open('sample_results.html'))
    results = fetch_results sample

    expect(results[0].class).to eq Nokogiri::XML::Element
  end
end
