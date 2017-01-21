require_relative 'fetch_data'

describe '#page_url' do
  it 'returns the correct url with page number' do
    expect(page_url 1).to eq "http://www.wegottickets.com/searchresults/page/1/all#paginate"
    expect(page_url 5).to eq "http://www.wegottickets.com/searchresults/page/5/all#paginate"
  end
end
