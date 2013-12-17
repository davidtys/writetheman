module Writetheman
  class Blog
    include Path

    def initialize(path_application)
      @path_application = path_application
    end

    def new_article
      Article::Base.new(@path_application)
    end

    def list_articles
      articles = {}
      list_source_files.each do |filepath|
        article = new_article
        article.load(Pathname.new( filepath ).basename.to_s)
        articles[article.title] = article
      end
      articles
    end  

  end
end