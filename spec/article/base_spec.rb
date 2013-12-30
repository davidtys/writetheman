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

  describe 'create' do
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

  describe 'update' do  
    date = DateTime.now
    oldtitle = get_random_title
    oldfilename = get_filename( oldtitle, date )
    oldfilepath = get_filepath( oldfilename )
    oldcontent = get_content
    newtitle = get_random_title
    newfilename = get_filename( newtitle, date )
    newfilepath = get_filepath( newfilename )
    newtags = get_random_tags
    newheader = get_header(newtitle, newtags, date)
    newbody = get_random_body
    newcontent = get_content( newheader, newbody )
    newheader_params = get_header_params(newtitle, newtags, date)
    newparams = { 'header' => newheader_params, 'body' => newbody }

    describe 'from init' do
    before(:all) { file_create(oldfilepath, oldcontent) }
    after(:all) do 
      file_delete(oldfilepath)
      file_delete(newfilepath)
    end

      it do
        File.exist?( oldfilepath ).should be_true
        File.open( oldfilepath, "rb").read.should_not eq( newcontent )
        article.title = newtitle
        article.date = date
        article.header = newheader
        article.body = newbody
        article.update( oldfilename )

        File.exist?( oldfilepath ).should be_false
        File.exist?( newfilepath ).should be_true
        File.open( newfilepath, "rb").read.should eq( newcontent )
      end
    end

    describe "from params" do
      before(:all) { file_create(oldfilepath, oldcontent) }
      after(:all) do 
        file_delete(oldfilepath)
        file_delete(newfilepath)
      end

      it do
        File.exist?( oldfilepath ).should be_true
        File.open( oldfilepath, "rb").read.should_not eq( newcontent )

        article.update_from_params(oldfilename, newparams)
        File.exist?( oldfilepath ).should be_false
        File.exist?( newfilepath ).should be_true
        File.open( newfilepath, "rb").read.should eq( newcontent )
      end      
    end          
  end  
end