module Writetheman
  class Blog
    include Path

    def initialize(path_application)
      @path_application = path_application
    end

    def list_articles
      articles = []
      list_source_files.each do |filepath|
        articles << Pathname.new( filepath ).basename.to_s
      end
      articles
    end  

  end
end