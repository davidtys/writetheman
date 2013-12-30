# Writetheman

Create, show and list the <a href='http://middlemanapp.com/basics/blogging/'>middleman blog</a> articles.

It's used by my middleman editor <a href='https://github.com/davidtysman/railstheman'>RailsTheMan</a> to manage articles in the browser.

## Installation

Add this line to your application's Gemfile:

    gem 'writetheman'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install writetheman

## Usage

### Init

Config the path of your local middleman :

	article = Writetheman::Article::Base.new(yourpath)
	blog = Writetheman::Blog.new(yourpath)

Init the article :

    article.title = title
    article.date = date
    article.body = body
    article.header = header # string
    OR article.header_params = {'tags'=>tags}

### Operations

Create a new article :

	article.create

Update an article :

    article.update(oldfilename)

Read an article file

	article.load_from_file(filename)
	OR article.load_from_title(title, date)
	
After loading it you have access to the article attributes

List articles :

	articles = blog.list_articles

## License

MIT, have fun