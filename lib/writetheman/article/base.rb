module Writetheman
  module Article
    class Base
      include Path
      include Access
      include Content
      include File
      include Utils

      def initialize(path_application)
        @path_application = path_application
        @extension = ".html.markdown"
      end  
     
      def create
        init_header_from_params if @header.nil? || @header.empty?
        init_content_from_header_body
        init_filename if @filename.nil? || @filename.empty?
        create_file
      end

      def read
        init_filename if @filename.nil? || @filename.empty?
        read_file
        init_header_body_from_content
        @all_content
      end  

    end
  end
end