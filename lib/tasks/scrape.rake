namespace :scrape do
  desc "Scrap goodreads and import data"
  task library: :environment do

    agent = Mechanize.new

    page = agent.get('https://www.goodreads.com/shelf/show/fiction')

    books = page.search('.left')

    books.each do |book|
      title = book.at('.leftAlignedImage').attributes['title'].value
      link = page.link_with(text: title)
      book_page = link.click
      info = book.search('.greyText' && '.smallText').at('span').text.strip.split(' ')
      b = Book.new
      b.title = title
      b.author = book.at('.authorName').text
      b.url = "https://goodreads.com#{book.at('.leftAlignedImage').attributes['href'].value}"
      b.image = book_page.at('#coverImage').attributes['src'].value
      b.avg_rating = info[2]
      b.num_rating = info[4].gsub(',', '')
      b.published = info[8]
      b.save
    end
  end
end
