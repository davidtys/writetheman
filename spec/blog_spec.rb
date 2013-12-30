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

    before(:all) do
      file_create(filepath1, content1)
    end    
    after(:all) do
      file_delete(filepath1)
    end

    describe 'files' do
      it do
        files = blog.send( :list_source_files )
        files.count.should eq(1)
        files.should include(filepath1)
      end
    end

    describe 'articles' do
      it do
        articles = blog.list_articles
        articles.count.should eq(1)        
        articles[0].title.should eq(title1) 
        articles[0].filename.should eq(filename1)
        articles[0].all_content.should eq(content1)
      end    
    end

  end      

end
