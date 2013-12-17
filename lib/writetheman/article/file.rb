module Writetheman
  module Article
    module File
      attr_accessor :filename, :extension

      private

        def create_file
          article_path = source_file_path
          raise "File already exists : #{article_path}" if ::File.exist?( article_path )
          raise "content is empty for create file #{@filename}" if @all_content.nil? || @all_content.empty?
          file = ::File.open( article_path, 'w' ) { |f| f.write( @all_content ) ; f.close }
        end

        def read_file
          article_path = source_file_path
          raise "File doesn't exist : #{article_path}" if !::File.exist?( article_path )
          file = ::File.open( article_path, "rb")
          @all_content = file.read
          file.close
          @all_content
        end

        def delete_article_file(title, date)
          check_path_source_blog
          article_path = article_source_file_path( article_filename_from_title( title, date )  )
          raise "File doesn't exist : #{article_path}" if !::File.exist?( article_path )
          ::File.delete article_path
        end     


        def source_file_path
          raise "filename is empty" if @filename.nil? || @filename.empty?
          check_path_source_blog
          path_source_blog + '/' + @filename
        end      
     
    end
  end
end