### Installation and Usage

Install with `bundle install`
Run with `bundle exec ruby run.rb`
Enter a full URL for the wikipedia page you wish to seek from.

### TODO
- Adding Threading is an obvious next step. As-is it's pretty slow for what
  it does. Bredth-first is quite a bit faster than depth-first
  processing, especially with the designated test-case.
  
- _Note:_ Depth-first functionality removed from test suite. I didn't realize
  I had scraped 300+ MBs of data from Wikipedia. I ended up rebasing and 
  squashing the VCR data commits together to clean the massive chunk out of 
  this repo's history, as github refused my first push.

- Using a library like Thor would help in passing in options to
  the Baconator. I opted to not add Thor because I'd been puttering
  on this for too long anyway.
