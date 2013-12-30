# Encoding: utf-8
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

      def create_from_params(params={})
        remove_access!
        init_from_params(params) if !params.empty?
        create
      end

      def read
        remove_content!
        init_filename
        read_file
        init_header_body_from_content
        @all_content
      end  

      def load_from_file(filename)
        remove_access!
        @filename = filename
        read
        @title = @header_params['title']
        @date = Date.parse(@header_params['date'])
      end

      def load_from_title(title, date)
        remove_access!
        @title = title
        @date = date
        read
      end      

      def update(oldfilename)
        delete_file(oldfilename)
        create
      end

      def update_from_params(oldfilename, params={})
        remove_access!
        init_from_params(params) if !params.empty?
        update(oldfilename)
      end      

      def remove_all!
        remove_access!
        remove_content!
      end

    end
  end
end