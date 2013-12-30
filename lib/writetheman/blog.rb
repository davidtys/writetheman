# Encoding: utf-8
module Writetheman
  class Blog
    include Path

    def initialize(path_application)
      @path_application = path_application
    end

    def new_article(filename='')
      article = Article::Base.new(@path_application)
      article.load_from_file(filename) if !filename.empty?
      article
    end

    def list_articles
      articles = []
      list_source_files.each do |filepath|
        articles << new_article(Pathname.new(filepath).basename.to_s)
      end
      articles
    end  

  end
end