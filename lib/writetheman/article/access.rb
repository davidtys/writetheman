module Writetheman
  module Article
    module Access
      attr_accessor :title, :date
      attr_reader :str_date

      def init_filename
        raise 'no title to create filename' if @title.nil? || @title.empty?
        raise 'no date to create filename' if @date.nil? 
        raise 'no extension to create filename' if @extension.nil? || @extension.empty?
        name = convert_title_to_filename
        @filename = "#{format_date_file}-#{name}#{@extension}"
      end


      private  

        def convert_title_to_filename
           I18n.transliterate( @title.gsub(" ", "-").gsub("'", "-").downcase )
        end  

        def format_date_file
          @date.strftime( "%Y-%m-%d" )
        end

        def format_date_header
          @date.strftime( "%Y-%m-%d %H:%M UTC" ) 
        end        
     
    end
  end
end