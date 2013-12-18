# Encoding: utf-8
module Writetheman
  module Article
    module Access
      attr_accessor :title, :date
      attr_reader :str_date

      def init_filename
        raise 'no extension to init filename' if @extension.nil? || @extension.empty?
        @filename = filename_from_title if @filename.nil? || @filename.empty?          
        @filename += @extension if !@filename.include?('.')
      end

      def init_from_params(params)
        raise 'params are empty to init' if params.nil? || params.empty?
        remove_all!
        @header_params = params['header']        
        @title = @header_params['title']
        @body = params['body']
        @date = DateTime.now if @date.nil? 
      end

      def filename_from_title
        raise 'no title to init filename' if @title.nil? || @title.empty?
        raise 'no date to init filename' if @date.nil? 
        name = convert_title_to_filename
        "#{format_date_file}-#{name}#{@extension}"
      end


      def filemane_without_extension
        @filename.match(/[^.]*/).to_s
      end

      def remove_access!
        @title = ''
        @date = nil
        @str_date = ''
      end

      private  

        def convert_title_to_filename
           raise 'no title to convert' if @title.nil? || @title.empty?
           I18n.transliterate( @title.gsub(" ", "-").gsub("'", "-").downcase )
        end  

        def format_date_file          
          raise 'no date to format' if @date.nil? 
          @date.strftime( "%Y-%m-%d" )
        end

        def format_date_header
          raise 'no date to format' if @date.nil? 
          @date.strftime( "%Y-%m-%d %H:%M UTC" ) 
        end        
     
    end
  end
end