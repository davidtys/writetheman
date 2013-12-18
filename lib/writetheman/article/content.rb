# Encoding: utf-8
module Writetheman
  module Article
    module Content
      attr_accessor :all_content, :body, :header, :header_params, :tags

      def check_header_params_valid
        raise "title is empty in header params #{@header_params}" if !@header_params.include?( 'title' ) || @header_params['title'].empty?
        raise "date is empty in header params #{@header_params}" if !@header_params.include?( 'date' ) || @header_params['date'].empty?
      end

      def remove_content!
        @all_content = ''
        @body = ''
        @header = ''
        @header_params = {}
        @tags = ''
      end

      private

        def init_header_from_params
          init_header_params
          @header = ""
          @header_params.each_with_index do |(index, value), i|
            @header += "#{index}: #{value}"
            @header += "\n" if i < @header_params.count - 1
          end
          check_header_params_valid
          @header
        end

        def init_content_from_header_body
          raise 'no header to get content' if @header.nil? || @header.empty?
          raise 'no body to get content' if @body.nil? || @body.empty?
          @all_content = "---" + "\n" + @header + "\n" + "---" + "\n\n" + @body
        end

        def init_header_params
          @header_params = {} if @header_params.nil?
          @header_params['date'] = format_date_header if !header_params.include?( 'date' )        
          @header_params['title'] = @title if !header_params.include?( 'title' )        

          @title = @header_params['title'] if @title.nil?
          @str_date = @header_params['date'] if @str_date.nil?
          @tags = @header_params['tags'] if @header_params.include?( 'tags' )
        end

        def init_header_params_from_content # get_header_params_from_content
          ar_lines = get_header_lines_from_content
          raise "no header lines from content #{@all_content}" if ar_lines.nil? || ar_lines.empty?

          @header_params = {}
          ar_lines.each do |value|
            line_values = value.split(':', 2)
            raise "line from header is invalid : #{line_values} from #{ar_lines}" if line_values.count != 2
            @header_params[line_values[0]] = line_values[1].strip!
          end
          @header_params
        end

        def init_header_body_from_content
          @header = get_header_from_content
          raise "no header from content \n#{@all_content}" if @header.nil? || @header.empty?
          @header_params = init_header_params_from_content
          raise "no header params from header \n#{@header}\nand content \n#{@all_content}" if @header_params.nil? || @header_params.empty?
          @body = get_body_from_content
          raise "no body from content \n#{@all_content}" if @body.nil? || @body.empty?
        end

        def get_body_from_content
          raise "content is empty" if @all_content.nil? || @all_content.empty?
          begin
            Utils::regex_body_from_content( @all_content ).strip!
          rescue Exception => e 
            raise "can't extract the body from content for the article #{@title} #{@filename} : \n#{e.message}"
          end
        end

        def get_header_from_content
          raise "content is empty" if @all_content.nil? || @all_content.empty?
          begin
            Utils::regex_header_from_content( @all_content )
          rescue Exception => e 
            raise "can't extract the header from content for the article #{@title} #{@filename} : \n#{e.message}"
          end
        end  
        
        def get_header_lines_from_content
           get_header_from_content.split("\n")
        end     

    end
  end
end
