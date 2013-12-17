# Encoding: utf-8
module Writetheman
  module Article
    module Utils
      REPLACE_CHARACTER = "|"
      
      def self.regex_header_from_content(content)
        #content = format_multibyte( content )
        content.gsub("\n", REPLACE_CHARACTER).match(/---(.*)---/).to_s.gsub(REPLACE_CHARACTER, "\n")
          .gsub("\r", "").gsub("---\n", "").gsub("\n---", "").gsub("---", "")
      end

      # if Windows-31J characters (don't need it with rich editor)
      # ex problem of encoding : http://www.weeklystandard.com/articles/silicon-chasm_768037.html
      # @todo better encoding
      def self.encoding_from_magazine(content)
        content.gsub('’', "'").gsub('“', '"').gsub('”', '"')
          .gsub('•', ' ').gsub('—', '-').gsub('¢', 'c').gsub('¡', '!').gsub('í', 'i')
          .gsub('é', 'e').gsub('â', 'a').gsub(".  .  . ", ". . . ")
      end

      def self.special_encoding(content)
        content = encoding_from_magazine( content )
        content
      end

      def self.format_content_from_file(content)
        content = special_encoding( content.force_encoding('utf-8') ).gsub("\r", "")
      end

      def self.regex_body_from_content(content)        
        content = format_content_from_file( content )
        content.match(/$(\n---\n)\s*$(.*)/ms).to_s.gsub("\n---\n", "")
      end

    end
  end
end