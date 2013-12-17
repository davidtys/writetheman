require 'spec_helper'

describe Writetheman::Article::Base do 

  let(:article) { FactoryGirl.build( :article ) }

   describe 'read article' do
    title = get_random_title
    filename = get_filename( title )
    filepath = get_filepath( filename )
    tags = get_random_tags
    date = DateTime.now
    header = get_header(title, tags, date)
    header_params = get_header_params(title, tags, date)
    body = get_random_body
    content = get_content(header, body)

    before(:all) { file_create(filepath, content) }
    after(:all) { file_delete(filepath) }

    describe "header" do
      describe "string" do
        it do
          article.title = title
          article.date = date
          article.read.should eq( content )
          article.header.should eq( header ) 
        end        
      end

      describe "params" do
        it do
          article.title = title
          article.date = date
          article.read.should eq( content )
          article.header_params.should eq( header_params )
        end      
      end
    end

    describe "body" do 
      it do
        article.title = title
        article.date = date
        article.read.should eq( content )
        article.body.should eq( body )
      end
    end
  end

  describe 'load article' do
    title = get_random_title
    filename = get_filename( title )
    filepath = get_filepath( filename )
    tags = get_random_tags
    date = DateTime.now
    header = get_header(title, tags, date)
    header_params = get_header_params(title, tags, date)
    body = get_random_body
    content = get_content(header, body)

    before(:all) { file_create(filepath, content) }
    after(:all) { file_delete(filepath) }

    describe "access" do
      it do
        article.load(filename)
        article.title.should eq(title)
        article.date.strftime("%Y-%m-%d").should eq(date.strftime("%Y-%m-%d"))
      end        
    end

    describe "content" do 
      it do
        article.load(filename)
        article.all_content.should eq( content )
      end
    end
  end  
end