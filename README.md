# Writetheman

Create, show and list the middleman blog articles.


## Installation

Add this line to your application's Gemfile:

    gem 'writetheman'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install writetheman

## Usage

config the path of your local middleman :
article = Writetheman::Article::Base.new('/dev/ruby/middleman')
blog = Writetheman::Blog.new('/dev/ruby/middleman')

from params :
article.create_from_params(params['article'])
article.load_from_file(filename)

or with the title and date of the file :
article.load_from_title(title, date)

or :
article.title = title
article.date = date
article.create
article.read

list files :
blog = Writetheman::Blog.new('/dev/ruby/middleman')
articles = blog.list_articles