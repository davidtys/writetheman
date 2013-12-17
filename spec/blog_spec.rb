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

  describe 'list articles files' do

    filepath1 = get_filepath
    filepath2 = get_filepath

    before(:all) do
      file_create(filepath1)
      file_create(filepath2)
    end    
    after(:all) do
      file_delete(filepath1)
      file_delete(filepath2)
    end

    it do
      files = blog.send( :list_source_files )
      files.count.should eq(2)
      files[0].should eq(filepath2)
      files[1].should eq(filepath1)
    end

  end      

end
