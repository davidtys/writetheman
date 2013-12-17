# Encoding: utf-8

PATH_APPLICATION = Dir.pwd + '/spec/tmp'
PATH_APPLICATION_SOURCE = PATH_APPLICATION + '/source'
PATH_APPLICATION_BUILD = PATH_APPLICATION + '/build'
PATH_APPLICATION_SOURCE_BLOG = PATH_APPLICATION_SOURCE + '/blog'
PATH_APPLICATION_BUILD_BLOG = PATH_APPLICATION_BUILD + '/blog'


def get_random_title(is_file=false)
  title = Faker::Lorem.words(3)
  is_file ? title = title.join('-') : title = title.join(' ')
  title
end

def get_random_tags
  Faker::Lorem.words.join(', ')
end

def get_random_body
  '<p>'+Faker::Lorem.paragraphs(2).join("</p>\n<p>")+'</p>'
end


def get_filename(title=get_random_title(true), date=DateTime.now)
  "#{date.strftime("%Y-%m-%d")}-#{title}.html.markdown"
end

def get_filepath(filename=get_filename)
  raise "filename is empty" if filename.nil? || filename.empty?
  PATH_APPLICATION_SOURCE_BLOG + "/" + filename 
end

def get_header(title=get_random_title, tags=get_random_tags, date=DateTime.now)
  "title: " + title + "\ntags: " + tags + "\ndate: " + date.strftime("%Y-%m-%d %H:%M UTC")
end

def get_header_params(title=get_random_title, tags=get_random_tags, date=DateTime.now)
  { 'title' => title, 'tags' => tags, 'date' => date.strftime("%Y-%m-%d %H:%M UTC") }
end

def get_content(header=get_header, body=get_random_body)
  "---" + "\n" + header + "\n" + "---" + "\n\n" + body
end

def file_create(filepath, content=get_content)
  raise "filepath is empty" if filepath.nil? || filepath.empty?
  File.open( filepath, 'w' ) { |f| f.write( content ) ; f.close } if !File.exist?( filepath )
end

def file_delete(filepath)
  raise "filepath is empty" if filepath.nil? || filepath.empty?
  File.delete( filepath ) if File.exist?( filepath )
end
