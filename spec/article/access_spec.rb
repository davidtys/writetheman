require 'spec_helper'

describe Writetheman::Article::Access do 

  let(:article) { FactoryGirl.build( :article ) }

  describe 'init filename' do
    title = get_random_title
    date = DateTime.now
    filename = get_filename( title, date )

    describe 'from title' do
      it do
        article.title = title
        article.date = date
        article.init_filename
        article.filename.should eq( filename ) 
      end        
    end
  end

  describe 'init params' do
    title = get_random_title
    date = DateTime.now
    filename = get_filename( title, date )
    filepath = get_filepath( filename )
    tags = get_random_tags
    header = get_header(title, tags, date)
    header_params = get_header_params(title, tags, date)
    body = get_random_body
    content = get_content(header, body)
    params = { 'header' => header_params, 'body' => body }

    it do
      article.init_from_params( params )
      article.header_params.should eq(header_params)
      article.title.should eq(title)
      article.body.should eq(body)
    end
  end

  describe 'filename' do
    describe 'set without extension' do
      it do
        filename_without_extention = "testfile"
        filename = filename_without_extention + ".html.markdown"
        article.filename = filename_without_extention
        article.init_filename
        article.filename.should eq(filename)
      end
    end

    describe 'get without extension' do
      it do
        filename_without_extention = "testfile"
        filename = filename_without_extention + ".html.markdown"
        article.filename = filename
        article.filemane_without_extension.should eq(filename_without_extention)
      end
    end
  end
end