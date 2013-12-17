module Writetheman
  module Path
    attr_accessor :path_application

    private

      def path_source
        raise "path application is empty" if @path_application.nil? || @path_application.empty?
        @path_application + "/source"
      end

      def path_source_blog
        path_source + "/blog"
      end

      def check_path_source_blog
        raise "path application is empty" if @path_application.nil? || @path_application.empty?
        raise "path source blog doesn't exist : #{path_source_blog}" if !::File.directory? path_source_blog
      end     

      def list_source_files
        Dir.glob( ::File.join(path_source_blog, "*") )
      end         

  end
end
