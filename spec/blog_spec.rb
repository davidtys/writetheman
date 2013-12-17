require 'spec_helper'

describe Writetheman::Blog do 
  let(:blog) { FactoryGirl.build( :blog ) }

  describe 'object' do 
    it { blog.should respond_to( :path_application ) }
  end

  describe 'paths' do
    it { blog.path_application.should eq( PATH_APPLICATION ) }
    it { blog.send( :path_source ).should eq( PATH_APPLICATION_SOURCE ) }
    it { blog.send( :path_source_blog ).should eq( PATH_APPLICATION_SOURCE_BLOG ) }
    it { blog.send( :check_path_source_blog ) }
  end

  describe 'list' do

    tags = get_random_tags
    date = DateTime.now
    body = get_random_body
    title1 = get_random_title
    filename1 = get_filename(title1)
    filepath1 = get_filepath(filename1)
    header1 = get_header(title1, tags, date)    
    content1 = get_content(header1, body)
    title2 = get_random_title
    filename2 = get_filename(title2)
    filepath2 = get_filepath(filename2)
    header2 = get_header(title2, tags, date)
    content2= get_content(header2, body)

    before(:all) do
      file_create(filepath1, content1)
      file_create(filepath2, content2)
    end    
    after(:all) do
      file_delete(filepath1)
      file_delete(filepath2)
    end

    describe 'files' do
      it do
        files = blog.send( :list_source_files )
        files.count.should eq(2)
        files.should include(filepath2)
        files.should include(filepath1)
      end
    end

    describe 'articles' do
      it do
        articles = blog.list_articles
        articles.count.should eq(2)        
        articles.should have_key(title1)
        articles[title1].title.should eq(title1)
        articles[title1].filename.should eq(filename1)
        articles[title1].all_content.should eq(content1)
        articles.should have_key(title1)
        articles[title2].title.should eq(title2)
        articles[title2].filename.should eq(filename2)
        articles[title2].all_content.should eq(content2)
      end    
    end

  end      

end
