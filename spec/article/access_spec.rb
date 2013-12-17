require 'spec_helper'

describe Writetheman::Article::Access do 

  let(:article) { FactoryGirl.build( :article ) }

   describe 'init finelame' do
    title = get_random_title
    date = DateTime.now
    filename = get_filename( title, date )

    it do
      article.title = title
      article.date = date
      article.init_filename
      article.filename.should eq( filename ) 
    end        
  end
end