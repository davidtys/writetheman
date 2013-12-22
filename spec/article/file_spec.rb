require 'spec_helper'

describe Writetheman::Article::File do 

  let(:article) { FactoryGirl.build( :article ) }

  describe 'create' do
    filename = get_filename
    filepath = get_filepath( filename )

    before(:all) { file_delete(filepath) }
    after(:all) { file_delete(filepath) }
    
    it do
      content = get_content
      article.filename = filename
      article.all_content = content
      File.exist?( filepath ).should be_false
      article.send( :create_file )
      
      File.exist?( filepath ).should be_true
      File.open( filepath, "rb").read.should eq( content )
    end
  end

  describe 'read' do
    filename = get_filename
    filepath = get_filepath( filename )
    title = get_random_title
    tags = get_random_tags
    date = DateTime.now
    header = get_header(title, tags, date)
    header_params = get_header_params(title, tags, date)
    content = get_content(header)

    before(:all) { file_create(filepath, content) }
    after(:all) { file_delete(filepath) }

    describe "all" do
      it do
        article.filename = filename
        article.send( :read_file ).should eq( content )
        article.all_content.should eq( content )
      end
    end

    describe "header" do
      describe "string" do
        it do
          article.filename = filename
          article.send( :read_file ).should eq( content )
          article.send( :get_header_from_content ).should eq( header ) 
        end        
      end

      describe "params" do
        it do
          article.filename = filename
          article.send( :read_file ).should eq( content )
          article.send( :init_header_body_from_content )
          article.header_params.should eq( header_params )
        end      
      end
    end
  end  

  describe "delete" do
    filename = get_filename
    filepath = get_filepath( filename )
   
    describe "from init" do
      before(:all) { file_create(filepath) }
      after(:all) { file_delete(filepath) }

      it do
        article.filename = filename
        article.send( :delete_file )
        File.exist?( filepath ).should be_false        
      end
    end

    describe "direct" do
      before(:all) { file_create(filepath) }
      after(:all) { file_delete(filepath) }

      it do
        article.send( :delete_file, filename )
        File.exist?( filepath ).should be_false        
      end
    end    
  end
end