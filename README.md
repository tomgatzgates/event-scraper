# Scraper
Scrape events from http://www.wegotickets.co.uk/

## To run
- Clone the repo
- `gem install 'nokogiri'`
- `ruby fetch_data.rb`

The script will create a data.yml file with all of the events

### Future iterations
- [ ] Convert to a ruby executable
- [ ] Optional argument for number of pages
- [ ] Filter our only music events (may require simulating mouse clicks)
- [ ] Just use the free [XML feeds](https://services.wegottickets.com/feeds/) 😉
