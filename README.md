### Installation and Usage

Install with `bundle install`
Run with `bundle exec ruby run.rb`
Enter a full URL for the wikipedia page you wish to seek from.

### TODO
- Adding Threading is an obvious next step. As-is it's pretty slow for what
  it does. Breadth-first is quite a bit faster than depth-first, especially 
  with the designated test-case.

- Using a library like Thor would help in passing in options to the Baconator,
  and general usability.

_Note:_ Depth-first functionality testing is disabled in the test suite. I didn't realize
I had scraped 300+ MBs of data from Wikipedia on several occasions, once into a single
VCR cassette, and github complained about that. I ended up modifying past commits to
purge that file and others out of the repo, if dates are wonkey that would be why.
