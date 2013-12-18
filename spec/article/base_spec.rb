require 'spec_helper'

describe Writetheman::Article::Base do 

  let(:article) { FactoryGirl.build( :article ) }

  describe 'read' do
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

  describe 'load' do
    title = get_random_title
    date = DateTime.now
    filename = get_filename( title, date )
    filepath = get_filepath( filename )
    tags = get_random_tags
    header = get_header(title, tags, date)
    header_params = get_header_params(title, tags, date)
    body = get_random_body
    content = get_content(header, body)

    before(:all) { file_create(filepath, content) }
    after(:all) { file_delete(filepath) }

    describe 'from file' do
      describe "access" do
        it do
          article.load_from_file(filename)
          article.title.should eq(title)
          article.date.strftime("%Y-%m-%d").should eq(date.strftime("%Y-%m-%d"))
        end        
      end

      describe "content" do 
        it do
          article.load_from_file(filename)
          article.all_content.should eq( content )
        end
      end
    end

    describe 'from title' do
      describe "access" do
        it do
          article.load_from_title(title, date)
          article.title.should eq(title)
          article.date.strftime("%Y-%m-%d").should eq(date.strftime("%Y-%m-%d"))
        end        
      end

      describe "content" do 
        it do
          article.load_from_title(title, date)
          article.all_content.should eq( content )
        end
      end
    end
  end  

  describe 'create'
    describe 'from params' do
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

      before(:all) { file_delete(filepath) }
      after(:all) { file_delete(filepath) }

      it do
        article.create_from_params( params )
        
        File.exist?( filepath ).should be_true
        File.open( filepath, "rb").read.should eq( content )
      end
    end

end