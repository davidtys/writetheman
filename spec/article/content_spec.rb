require 'spec_helper'

describe Writetheman::Article::Content do 

  let(:article) { FactoryGirl.build( :article ) }

   describe 'read article' do
    describe "header" do

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

      describe "string" do
        it do
          article.filename = filename
          article.read.should eq( content )
          article.header.should eq( header ) 
        end        
      end

      describe "params" do
        it do
          article.filename = filename
          article.read.should eq( content )
          article.header_params.should eq( header_params )
        end      
      end

    end
  end
end